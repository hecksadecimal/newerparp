class AllowNullBetaCodeAccountId < ActiveRecord::Migration[7.1]
  def change
    change_column_null :beta_codes, :account_id, true
  end
end
