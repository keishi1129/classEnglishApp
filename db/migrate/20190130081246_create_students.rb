class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.integer :vocabulary, default: 0
      t.integer :wpm, default: 0
      t.references :classroom, foreign_key: true
      t.timestamps
    end
  end
end
