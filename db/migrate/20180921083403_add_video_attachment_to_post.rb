class AddVideoAttachmentToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :video_attachment, :string
  end
end
