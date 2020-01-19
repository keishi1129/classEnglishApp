class CardsetWord < ApplicationRecord
  belongs_to :word
  belongs_to :cardset
end
