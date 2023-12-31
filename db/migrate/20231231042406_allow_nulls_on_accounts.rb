class AllowNullsOnAccounts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :accounts, :acronym, true
    change_column_null :accounts, :name, true
    change_column_null :accounts, :color, true
  end
end
