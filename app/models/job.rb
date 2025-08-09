class Job < ApplicationRecord
  acts_as_paranoid
  has_paper_trail ignore: [:published, :published_at]

  belongs_to :user, required: false
  belongs_to :employer, required: false

  enum :job_type, {
    full_time: 0, part_time: 1, temporary: 2, contract: 3, internship: 4, rfp: 5, contest: 6,
    uncategorized: 7 }, default: :full_time

  scope :published, ->() { where(published: true) }
  scope :unpublished, ->() { where(published: false) }

  scope :published_since, ->(time) { published.where('created_at >= ?', time) }
  scope :recent, ->() { published_since(2.months.ago) }
  scope :from_last_week, ->() { published_since(1.week.ago) }

  default_scope { order(created_at: :desc, published_at: :desc) }

  validates :title, :description, :job_type, presence: true

  acts_as_taggable
  before_validation :run_spam_analysis, on: :create
  after_save :send_job_email, if: :just_published?
  after_save :send_slack_notification, if: :just_published?

  def to_param
    "#{id}-#{slug}"
  end

  def slug
    title.to_s.parameterize
  end

  def display_title
    if employer
      "#{title} at #{employer.name}"
    else
      title
    end
  end

  def employer_name
    employer&.name
  end

  def employer_name=(value)
    self.employer = Employer.find_or_create_by(name: value)
  end

  def publish!
    update(published: true, published_at: Time.now)
  end

  def run_spam_analysis
    return unless posted_on_site?

    classification = Classifier.classify(self)

    if classification == 'Spam'
      update(title: "[SPAM] #{title}")
      destroy
    end
  end

  def send_job_email
    JobMailer.single(self).deliver_later if posted_on_site?
  end

  def send_slack_notification
    SlackNotificationJob.perform_later(self)
  end

  def just_published?
    !attribute_before_last_save('published') && published?
  end

  def expired?
    created_at < Time.zone.now - 2.months
  end

  def posted_on_site?
    origin =~ /jobs\.code4lib\.org/
  end
end
