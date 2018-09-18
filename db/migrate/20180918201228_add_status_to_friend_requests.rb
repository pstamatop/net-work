class AddStatusToFriendRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :friend_requests, :status, :integer
  end
end
