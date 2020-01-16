class Word < ApplicationRecord

  belongs_to :cardset, optional: true
  scope :old10, -> { order(created_at: :asc).limit(10)}

  enum status: {
    unpublished:1,
    unmemorized:2,
    memorized:3
  }
end
