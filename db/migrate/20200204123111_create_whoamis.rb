class CreateWhoamis < ActiveRecord::Migration[6.0]
  def change
    create_table :whoamis do |t|
      t.string :name, null: false
      t.integer :type, default: 1, null: false
      t.timestamps
    end
  end
end
