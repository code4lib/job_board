class Job < ApplicationRecord
  has_paper_trail ignore: [:published, :published_at]

  belongs_to :user
  belongs_to :employer

  enum job_type: [:full_time, :part_time, :temporary, :contract, :internship, :rfp, :contest]

  scope :published, ->() { where(published: true) }
  
  default_scope { order(published_at: :desc, created_at: :desc) }
  
  validates :title, :description, :url, presence: true

  acts_as_taggable
end
