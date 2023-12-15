class AddMoreDefaultsToAccounts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :accounts, "replacements", ""
    change_column_default :accounts, "regexes", ""
  end
end
