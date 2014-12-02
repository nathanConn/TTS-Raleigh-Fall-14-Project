class User < ActiveRecord::Base

	has_one :user
    has_many :posts

	before_save {self.email = email.downcase}
	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
			  format: { with: VALID_EMAIL_REGEX },
			  uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 8}

end
