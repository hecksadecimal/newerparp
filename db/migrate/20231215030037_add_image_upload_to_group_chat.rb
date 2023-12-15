class AddImageUploadToGroupChat < ActiveRecord::Migration[7.1]
  def change
    add_column :group_chats, :image_upload, :boolean, default: false
  end
end
