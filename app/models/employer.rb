class Employer < ApplicationRecord
  has_paper_trail

  extend FriendlyId

  has_many :jobs

  friendly_id :slug_candidates, use: [:slugged, :finders]

  default_scope { order(name: :asc) }

  validates :name, presence: true

  def slug_candidates
    [:name]
  end
end
