class ChangeAttachmentToBeStringInPosts < ActiveRecord::Migration[5.1]
  def change
  	change_column :posts, :attachment, :string
  end
end
