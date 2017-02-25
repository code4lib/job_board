class Job < ApplicationRecord
  belongs_to :user
  belongs_to :employer

  enum job_type: [:full_time, :part_time, :temporary, :contract, :internship, :rfp, :contest]

  scope :published, ->() { where(published: true) }
end
