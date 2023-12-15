class AddRenderModeToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :render_mode, :integer, default: 0
  end
end
