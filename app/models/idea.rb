class Idea < ActiveRecord::Base
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes #, source: :user

  has_many :members, dependent: :destroy
  has_many :member_users, through: :members, source: :user

  validates :title, presence: true, uniqueness: { scope: :user }
  validates :body, presence: true


  def user_full_name
    user.full_name if user
  end

  def like_for(user)
    likes.find_by(user_id: user)
  end

  def member_of(user)
    members.find_by(user_id: user)
  end



end
