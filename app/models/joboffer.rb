class Joboffer < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 140 }
  validates :title, presence: true
end
