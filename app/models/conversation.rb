class Conversation < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy
  default_scope -> { order(updated_at: :desc) }
end
