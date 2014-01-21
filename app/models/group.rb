class Group < ActiveRecord::Base
	has_secure_password
	before_save { self.email = email.downcase }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: {minimum: 3, maximum: 10}
	validates :email, presence: true, 
										uniqueness: {case_sensitive: false},
										length: {minimum: 6, maximum: 30}, 
										format: {with: VALID_EMAIL_REGEX}
	validates :password, length: {minimum: 6, maximum: 50}
end
