class ChangeAttachmentToBeJsonInPosts < ActiveRecord::Migration[5.1]
  def change
  	change_column :posts, :attachment, :json, using: 'attachment::JSON'
  end
end
