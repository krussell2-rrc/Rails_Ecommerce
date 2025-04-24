class User < ApplicationRecord
  validates :username, :password_hash, :email_address, presence: true
  validates :username, :email_address, uniqueness: true
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }
end
