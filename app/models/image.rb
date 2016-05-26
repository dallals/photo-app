class Image < ActiveRecord::Base
  belongs_to :user
  # belongs_to :freeuser
  mount_uploader :picture, PictureUploader
  validate :picture_size


  def self.search(param)
  	return Image.none if param.blank?
  	param.strip!
  	param.downcase!
  	name_matches(param).uniq 
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
