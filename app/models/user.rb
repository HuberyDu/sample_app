class User < ActiveRecord::Base
  # attr_accessor :name, :email

  validates :name, presence: true, length: {maximum: 10}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    format:{with: VALID_EMAIL_REGEX}

  has_secure_password
end
