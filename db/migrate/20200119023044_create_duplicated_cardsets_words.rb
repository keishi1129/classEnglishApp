class CreateDuplicatedCardsetsWords < ActiveRecord::Migration[6.0]
  def change
    create_table :duplicated_cardsets_words do |t|
      t.references :word, foreign_key: true
      t.references :duplicated_cardset, foreign_key: true
      t.timestamps
    end
  end
end
