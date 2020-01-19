class AddCardsetsWordsIdToWords < ActiveRecord::Migration[6.0]
  def change
    add_reference :words, :cardset_word, foreign_key: true
  end
end
