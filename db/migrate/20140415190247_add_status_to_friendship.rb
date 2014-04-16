class AddStatusToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :status, :integer
    add_column :friendships, :accepted_at, :datetime
    add_index :friendships, [:user_id, :friend_id, :accepted_at]
  end
end
