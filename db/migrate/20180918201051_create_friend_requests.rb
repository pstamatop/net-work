class CreateFriendRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_requests do |t|
      t.integer :request_sender
      t.integer :request_receiver

      t.timestamps
    end
    add_index :friend_requests, :request_sender
    add_index :friend_requests, :request_receiver
    add_index :friend_requests, [:request_sender, :request_receiver], unique: true
  end
end
