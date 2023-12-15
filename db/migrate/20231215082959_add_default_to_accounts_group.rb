class AddDefaultToAccountsGroup < ActiveRecord::Migration[7.1]
  def change
    change_column_default :accounts, :group, "active"
  end
end
