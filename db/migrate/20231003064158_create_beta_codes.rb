class CreateBetaCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :beta_codes do |t|
      t.text :code
      t.belongs_to :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
