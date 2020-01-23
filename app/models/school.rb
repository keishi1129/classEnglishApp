class School < ApplicationRecord
  validates :name, presence: true

  has_many :classrooms, dependent: :destroy
  has_many :teachers, dependent: :destroy
  has_many :posts, dependent: :destroy
end
