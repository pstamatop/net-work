class Joboffer < ApplicationRecord
  belongs_to :user
  has_many :applies, dependent: :destroy

  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 140 }
  validates :title, presence: true
end
