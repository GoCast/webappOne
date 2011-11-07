require 'digest/md5'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password. 
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20]) 
    end
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  scope :ordered, order("online DESC")

  def image_url
    "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}}"
  end

  def online!
		self.online = true
    save
  end

  def offline!
		self.online = false
    save
  end

  def username
		self.email.split("@").first
  end

  def status
		self.online ? "Online" : "Offline"
  end

  def as_json(params = {})
		{
      id: id,
      username: username,
      email: email,
      image_url: image_url,
      status: status,
      rtsp_url: rtsp_url
    }
  end

  class << self

    def digest
      Digest::MD5.hexdigest(User.all.to_json)
    end
      
  end

end
