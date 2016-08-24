# class Freeuser < ActiveRecord::Base
# 	# has_secure_password
# 	# has_many :images
# 	# has_many :users
# 	# before_save { self.email = email.downcase }
# 	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
# 	# validates :name, presence: true, length: { minimum: 3, maximum: 100 }
# 	# validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }


#   def self.search(email)
#     names_array = name.split(' ')
#     if names_array.size == 1
#       where('email LIKE ?', "%#{names_array[0]}%", "%#{names_array[0]}%").order(:email)
#     else
#       where('email LIKE ? or email LIKE ?', 
#     "%#{names_array[0]}%", "%#{names_array[1]}%", "%#{names_array[0]}%", "%#{names_array[1]}%").order(:email)
#     end 
#   end

# end
