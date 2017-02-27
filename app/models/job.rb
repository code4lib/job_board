class Job < ApplicationRecord
  has_paper_trail ignore: [:published, :published_at]

  belongs_to :user
  belongs_to :employer

  enum job_type: [:full_time, :part_time, :temporary, :contract, :internship, :rfp, :contest]

  scope :published, ->() { where(published: true) }
  scope :unpublished, ->() { where(published: false) }

  scope :published_since, ->(time) { published.where('created_at >= ?', time) }
  scope :recent, ->() { published_since(2.months.ago) }
  scope :from_last_week, ->() { published_since(1.week.ago) }

  default_scope { order(published_at: :desc, created_at: :desc) }
  
  validates :title, :description, :url, :job_type, :employer, presence: true

  acts_as_taggable

  after_save :send_job_email, if: :just_published?

  def employer_name
    employer.name
  end
  
  def employer_name=(value)
    self.employer = Employer.find_or_create_by(name: value)
  end

  def publish!
    update(published: true, published_at: Time.now)
  end

  def send_job_email
    JobMailer.single(self).deliver_later
  end

  def just_published?
    !attribute_before_last_save('published') && published?
  end
end
