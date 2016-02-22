class Idea < ActiveRecord::Base
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes #, source: :user

  validates :title, presence: true, uniqueness: { scope: :user }
  validates :body, presence: true


  def user_full_name
    user.full_name if user
  end

  def like_for(user)
    likes.find_by(user_id: user)
  end

end
