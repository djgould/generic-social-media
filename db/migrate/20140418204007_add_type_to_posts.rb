class AddTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :type, :string
    add_column :posts, :friend_id, :integer
  end
end
