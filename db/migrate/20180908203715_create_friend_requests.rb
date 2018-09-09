class CreateFriendRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_requests do |t|
      t.integer :request_user
      t.integer :request_friend

      t.timestamps
    end
    add_index :friend_requests, :request_user
    add_index :friend_requests, :request_friend
    add_index :friend_requests, [:request_user, :request_friend], unique: true
  end
end
