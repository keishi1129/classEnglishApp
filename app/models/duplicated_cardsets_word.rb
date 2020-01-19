class DuplicatedCardsetsWord < ApplicationRecord
  belongs_to :word
  belongs_to :duplicated_cardset
end
