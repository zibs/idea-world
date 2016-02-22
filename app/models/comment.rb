class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :body, presence: true

  def user_full_name
    user.full_name if user
  end
  
end
