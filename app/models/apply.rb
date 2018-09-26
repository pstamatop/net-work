class Apply < ApplicationRecord
  belongs_to :user
  belongs_to :joboffer

  validates :user_id, presence: true
  validates :joboffer_id, presence: true
end
