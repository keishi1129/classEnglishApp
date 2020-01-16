class DuplicatedCardset < ApplicationRecord
  belongs_to :origin, class_name: "Cardset"
  has_many :words
  belongs_to :user, foreign_key: true, optional: true

  enum status: {
    learning:1,
    completed:2
  }

  
  
end
