class AddCardsetsIdToWords < ActiveRecord::Migration[6.0]
  def change
    add_reference :words, :cardset, foreign_key: true
  end
end
