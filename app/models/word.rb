class Word < ApplicationRecord

  has_many :cardset_words
  has_many :cardsets, through: :cardset_words
  scope :old10, -> { order(created_at: :asc).limit(10)}

  enum status: {
    unpublished:1,
    unmemorized:2,
    memorized:3
  }

  def get_random(number)
    words = []
    i = 0
    while i < number do
      words << self.find(rand(0...number))
    end
    return words
  end
end
