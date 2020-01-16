class CreateDuplicatedCardsets < ActiveRecord::Migration[6.0]
  def change
    create_table :duplicated_cardsets do |t|
      t.string :name
      t.references :origin, foreign_key: { to_table: :cardsets }
      t.references :user, foreign_key: true
      t.integer :status, default: 1
      t.timestamps
    end
  end
end
