class CreateClassrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :classrooms do |t|
      t.string :name, null: false
      t.string :password, null: false
      t.references :teacher, foreign_key: true
      t.timestamps
    end
  end
end
