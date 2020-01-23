class CreateCardsets < ActiveRecord::Migration[6.0]
  def change
    create_table :cardsets do |t|
      t.string :name, null: false
      t.integer :use, default: 1
      t.references :student
      t.references :teacher
      t.timestamps
    end
  end
end
