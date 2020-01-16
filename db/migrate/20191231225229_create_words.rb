class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :name, null: false
      t.string :meaning, null: false
      t.integer :status, null: false, default: 1
      t.timestamps
    end
  end
end
