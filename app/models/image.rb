class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :album 
  has_many :image_albums
  has_many :albums, through: :image_albums
  # belongs_to :freeuser
  mount_uploader :picture, PictureUploader
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validate :picture_size


  def self.search(param)
  	return Image.all if param.blank?
  	param.strip!
  	param.downcase!
  	(name_matches(param) + caption_matches(param) + credit_matches(param)).uniq 
  	# caption_matches(param).uniq 
  	# credit_matches(param)
  	
  end

  def self.name_matches(param)
  	matches('name', param)
  end

  def self.caption_matches(param)
  	matches('caption', param)
  end

  def self.credit_matches(param)
  	matches('credit', param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end

	private

	def picture_size
		if picture.size > 5.megabytes
			errors.add(:picture, "should be less the 5MB")
		end
	end
end
