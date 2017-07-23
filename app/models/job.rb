class Job < ApplicationRecord
  acts_as_paranoid
  has_paper_trail ignore: [:published, :published_at]

  belongs_to :user
  belongs_to :employer

  enum job_type: [:full_time, :part_time, :temporary, :contract, :internship, :rfp, :contest, :uncategorized]

  scope :published, ->() { where(published: true) }
  scope :unpublished, ->() { where(published: false) }

  scope :published_since, ->(time) { published.where('created_at >= ?', time) }
  scope :recent, ->() { published_since(2.months.ago) }
  scope :from_last_week, ->() { published_since(1.week.ago) }

  default_scope { order(created_at: :desc, published_at: :desc) }
  
  validates :title, :description, :job_type, presence: true

  acts_as_taggable
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

  def send_job_email
    JobMailer.single(self).deliver_later if origin =~ /jobs\.code4lib\.org/
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
end
