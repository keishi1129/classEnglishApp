class Teacher < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :classrooms
  has_many :students, through: :classrooms
  has_many :cardsets
end
