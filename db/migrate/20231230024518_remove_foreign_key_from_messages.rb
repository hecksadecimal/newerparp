class RemoveForeignKeyFromMessages < ActiveRecord::Migration[7.1]
  def change
    if foreign_key_exists?(:messages, :users)
      remove_foreign_key :messages, :users
    end
  end
end
