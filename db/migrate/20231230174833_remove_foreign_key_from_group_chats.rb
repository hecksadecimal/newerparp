class RemoveForeignKeyFromGroupChats < ActiveRecord::Migration[7.1]
  def change
    if foreign_key_exists?(:group_chats, :users)
      remove_foreign_key :group_chats, :users
    end
  end
end
