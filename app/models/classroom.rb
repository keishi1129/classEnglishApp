class Classroom < ApplicationRecord
  belongs_to :teacher
  has_many :students, dependent: :destroy
  has_many :cardsets, dependent: :destroy

end
