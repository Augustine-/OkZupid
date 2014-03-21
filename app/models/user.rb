class User < ActiveRecord::Base
  attr_reader :password

  before_validation :ensure_session_token
  
  validates :species, presence: true
  validates :username, uniqueness: true, presence: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :token, presence: true, uniqueness: true

  has_one :profile
  
  has_many :posts,
  through: :profile,
  source: :posts


  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user.try(:is_password?, password) ? user : nil
  end

  def self.generate_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end

  def password=(secret)
    if(secret).present?
      @password = secret
      self.password_digest = BCrypt::Password.create(secret)
    end
  end

  def reset_token!
    self.token = self.class.generate_token
    self.save!
    self.token
  end

  private
  def ensure_session_token
    self.token ||= self.class.generate_token
  end
end
