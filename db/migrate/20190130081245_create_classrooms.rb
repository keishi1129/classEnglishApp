class CreateClassrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :classrooms do |t|
      t.string :name, null: false
      t.string :classroom_code, null: false, unique: true
      t.references :teacher, foreign_key: true
      t.timestamps
    end
  end
end
