class AddOriginToBetaCodes < ActiveRecord::Migration[7.1]
  def change
    add_column :beta_codes, :origin, :string, default: ""
  end
end
