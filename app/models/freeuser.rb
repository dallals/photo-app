class Freeuser < ActiveRecord::Base
	has_secure_password
	has_many :images
	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: { minimum: 3, maximum: 100 }
	validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }


	def self.search(param)
	  	return User.all if param.blank?
	  	param.strip!
	  	param.downcase!
	  	email_matches(param).uniq 
	end


	def self.email_matches(param)
		matches('email', param)
	end

	def self.matches(field_name, param)
		where("lower(#{field_name}) like ?", "%#{param}%")
	end


end
