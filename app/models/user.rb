class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :timeoutable, :timeout_in => 180.minutes       
  has_one :payment
  accepts_nested_attributes_for :payment
  has_many :images, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :first_name, presence: true
  validates :last_name, presence: true
  # rails_admin do 
  #   object_label_method :email 
  # end 
  # acts_as_taggable

  def full_name
    "#{first_name} #{last_name}"
  end


  def self.search_by_name(name) 
    return User.none if name.blank?
    names_array = name.split(' ')
    if names_array.size == 1
      where('first_name LIKE ? or last_name LIKE ?', "%#{names_array[0]}%", "%#{names_array[0]}%").order(:first_name)
    else
      where('first_name LIKE ? or first_name LIKE ? or last_name LIKE ? or last_name LIKE ?', 
    "%#{names_array[0]}%", "%#{names_array[1]}%", "%#{names_array[0]}%", "%#{names_array[1]}%").order(:first_name)
    end 
  end

  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end
	
end	