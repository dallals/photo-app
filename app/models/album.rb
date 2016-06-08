class Album < ActiveRecord::Base
  has_many :image_albums
  has_many :images, through: :image_albums
  # has_many :images
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  belongs_to :user
end
