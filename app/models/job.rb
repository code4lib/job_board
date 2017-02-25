class Job < ApplicationRecord
  belongs_to :user
  belongs_to :employer
end
