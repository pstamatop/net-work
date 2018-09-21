class AddAudioAttachmentToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :audio_attachment, :string
  end
end
