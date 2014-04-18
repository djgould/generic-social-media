class Post < ActiveRecord::Base
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
  
  def self.friends_posts(user)
    friends_ids = "SELECT friend_id FROM friendships WHERE user_id = :user_id AND status = 0"
    where("user_id IN (#{friends_ids}) OR user_id = :user_id", user_id: user.id).order("created_at DESC")
  end
  
  def self.wall_posts(user)
    friends_ids = "SELECT friend_id FROM friendships 
          WHERE user_id = :user_id AND status = 0"
    where("(user_id IN (#{friends_ids}) AND type = 'WallPost') 
          OR user_id = :user_id", user_id: user.id).order("created_at DESC")
  end
end
