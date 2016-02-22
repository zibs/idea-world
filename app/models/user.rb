class User < ActiveRecord::Base
  has_secure_password
  has_many :ideas, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_ideas, through: :likes, source: :question

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password, length: { minimum: 5 }, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
            uniqueness: true,
            format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}".titleize.strip
  end

end
