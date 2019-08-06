# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :user_name, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 8 , message: "make me longer"}, allow_nil: true

  after_initialize :make_the_token
  attr_reader :password

  has_many :cats

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def password=(pw)
    self.password_digest = BCrypt::Password.create(pw) # hashes pw and stores in pd
    @password = pw # used to check validations
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def self.find_by_credentials(user_name, pw)
    user = User.find_by(user_name: user_name)
    return nil unless user
    return user.is_password?(pw) ? user : nil
  end

  def make_the_token
    self.session_token = SecureRandom.urlsafe_base64
  end
end
