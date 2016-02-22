class Idea < ActiveRecord::Base
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :title, presence: true, uniqueness: { scope: :user }
  validates :body, presence: true


  def user_full_name
    user.full_name if user
  end

end
