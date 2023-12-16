class AddDefaultsToMessages < ActiveRecord::Migration[7.1]
  def change
    change_column_default :messages, "text", ""
    change_column_default :messages, "color", ""
    change_column_default :messages, "acronym", ""
    change_column_default :messages, "name", ""
  end
end
