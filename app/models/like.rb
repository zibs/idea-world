class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea

  validates :user_id, :idea_id, presence: true
  validates :idea_id, uniqueness: { scope: :user_id }
  
end
