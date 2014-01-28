class Group < ActiveRecord::Base
	has_many :lessons, dependent: :destroy

	before_save {self.email = email.downcase}
	before_create :create_remember_token

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: {minimum: 3, maximum: 50}
	validates :email, presence: true, 
										uniqueness: {case_sensitive: false},
										length: {minimum: 6, maximum: 30}, 
										format: {with: VALID_EMAIL_REGEX}
	validates :password, length: {minimum: 6, maximum: 50}
	has_secure_password

	 def Group.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Group.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = Group.encrypt(Group.new_remember_token)
    end
end
