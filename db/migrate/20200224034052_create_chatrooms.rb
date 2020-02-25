class CreateChatrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chatrooms do |t|
      t.string :name
      t.index :name, unique: true
      t.references :classroom, foreign_key: true
      t.timestamps
    end
  end
end
