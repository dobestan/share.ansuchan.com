class User < ActiveRecord::Base
  before_create :create_remember_token

  has_secure_password

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false },
                   length: { minimum: 4 }

  validates :password, presence: true,
                      length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :password_digest, presence: true

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
