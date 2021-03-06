

class User < ActiveRecord::Base
  
	attr_accessor :remember_token, :activation_token, :reset_token
  	before_save   :downcase_email
    before_create :create_activation_digest
    mount_uploader :picture, PictureUploader
    validate  :picture_size

	  has_one :user
    has_many :posts, dependent: :destroy
    has_many :comments

    acts_as_voter



	before_save {self.email = email.downcase}
  validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
			  format: { with: VALID_EMAIL_REGEX },
			  uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 8}, allow_blank: true


	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
	    BCrypt::Password.create(string, cost: cost)
	    end

	def User.new_token
	SecureRandom.urlsafe_base64
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  	end

  	def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
    end

    # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end


    private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
