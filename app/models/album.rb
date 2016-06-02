class Album < ActiveRecord::Base
  has_many :image_albums
  has_many :images, through: :image_albums
  # has_many :images
  validates :name, presence: true, length: { mainmum: 3, maximum: 25 }
  # validates_uniqueness_of :name
  belongs_to :user
end
