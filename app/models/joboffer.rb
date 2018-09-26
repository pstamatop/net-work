class Joboffer < ApplicationRecord
  belongs_to :user
  has_many :applies, dependent: :destroy
  default_scope -> { order(created_at: :desc) }

  has_and_belongs_to_many :tskills

  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :title, presence: true
end
