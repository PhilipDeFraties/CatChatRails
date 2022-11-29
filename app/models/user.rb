class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 4 }

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
