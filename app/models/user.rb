class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :payment
  accepts_nested_attributes_for :payment
  has_many :images, dependent: :destroy
  has_many :albums, dependent: :destroy

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