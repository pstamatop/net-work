class CreateConversations < ActiveRecord::Migration[5.1]
  def change
    create_table :conversations do |t|
      t.references :user, foreign_key: true
      t.integer :receiver

      t.timestamps
    end
    add_index :conversations, [:user_id, :updated_at]
  end
end
