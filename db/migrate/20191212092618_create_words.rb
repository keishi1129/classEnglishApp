class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :name, null: false
      t.string :meaning, null: false
      t.integer :level, null: false, default: 1
      t.references :cardset
      t.references :duplicated_cardset
      t.timestamps
    end
  end
end
