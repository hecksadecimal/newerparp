class CreateAnnouncements < ActiveRecord::Migration[7.1]
  def change
    create_table :announcements do |t|
      t.string :title
      t.references :account, foreign_key: true
      t.timestamps
    end
  end
end
