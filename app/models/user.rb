class User < ActiveRecord::Base
  # attr_accessor :name, :email

  validates :name, presence: true, length: {maximum: 30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format:{with: VALID_EMAIL_REGEX}

  has_secure_password

  before_create :create_remember_token

  def self.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  private
  	
  	def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
