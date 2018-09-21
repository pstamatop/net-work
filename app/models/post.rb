class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  default_scope -> { order(created_at: :desc) }
  mount_uploaders :attachment, AvatarUploader
  mount_uploader :video_attachment, VideoUploader
  mount_uploader :audio_attachment, AudioUploader
  serialize :attachment, JSON
  validates :user_id, presence: true
  #validates :content, presence: true, length: { maximum: 140 }
  validates :content, length: { maximum: 140 }
  validate :not_empty
  validate  :attachment_size


  	# Validates that the post is not empty
    def not_empty
    	if not content.present?
      		if not attachment.present? || video_attachment.present? || audio_attachment.present?
      			errors.add(:post,"can't be empty.")
      		end
   		end
   	end

   	# Validates the size of an uploaded picture.
    def attachment_size
      attachment.each do |a|
      	if a.size > 5.megabytes
       		errors.add(:attachment, "should be less than 5MB")
      	end
      end
    end


end
