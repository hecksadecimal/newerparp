class AddLastSeenAtToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :last_seen_at, :datetime
  end
end
