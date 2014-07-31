require 'securerandom'

class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 8}


  before_validation on: :create do
    self.api_token = SecureRandom.hex
  end

end
