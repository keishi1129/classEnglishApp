class Classroom < ApplicationRecord
  belongs_to :teacher
  has_many :students, dependent: :destroy

end
