class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploaders :attachment, AvatarUploader
  serialize :attachment, JSON
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
