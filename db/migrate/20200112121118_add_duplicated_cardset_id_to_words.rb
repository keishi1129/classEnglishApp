class AddDuplicatedCardsetIdToWords < ActiveRecord::Migration[6.0]
  def change
    add_reference :words, :duplicated_cardset, foreign_key: true
  end
end
