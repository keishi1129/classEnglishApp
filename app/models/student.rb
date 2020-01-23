class Student < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  belongs_to :classroom
  has_one :teacher, through: :classroom
  has_many :cardsets, dependent: :destroy
  has_many :duplicated_cardsets, dependent: :destroy
 
 

end
