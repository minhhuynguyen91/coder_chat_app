class AddFriendListToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :friend_list_ids, :integer, array:true, default: []
  end
end
