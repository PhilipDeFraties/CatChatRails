class User < ApplicationRecord
  has_secure_password

  enum role: { admin: 0 }

  validates :username, presence: true, uniqueness: true, length: { minimum: 4 }
  validates :password, presence: true, length: { minimum: 6 }
  # validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  before_validation :downcase_email

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
