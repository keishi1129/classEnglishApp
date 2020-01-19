class CreateCardsetWords < ActiveRecord::Migration[6.0]
  def change
    create_table :cardset_words do |t|
      t.references :word, foreign_key: true
      t.references :cardset, foreign_key: true
      t.timestamps
    end
  end
end
