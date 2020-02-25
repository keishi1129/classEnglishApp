class Message < ApplicationRecord
  belongs_to :student
  mount_uploader :image, ImageUploader
  validates :content, presence: true, unless: :image?
end
