class CreateCardsets < ActiveRecord::Migration[6.0]
  def change
    create_table :cardsets do |t|
      t.string :name, null: false
      t.integer :use, default: 1
      t.timestamps
    end
  end
end
