class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  belongs_to :classroom
  has_one :teacher, through: :classroom
  has_many :cardsets, dependent: :destroy
  has_many :duplicated_cardsets, dependent: :destroy
 
 

end
