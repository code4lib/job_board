class Employer < ApplicationRecord
  extend FriendlyId

  has_many :jobs

  friendly_id :slug_candidates, use: [:slugged, :finders]
  
  def slug_candidates
    [:name]
  end
end
