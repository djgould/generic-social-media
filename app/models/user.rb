class User < ActiveRecord::Base
  before_create :create_auth_token
  has_many :friendships
  has_many :friends, through: :friendships, conditions: [%(status = ?), Friendship::ACCEPTED]
  has_many :requested_friends, through: :friendships, source: :friend, conditions: [%(status = ?), Friendship::REQUESTED]
  has_many :posts  
  has_many :wall_posts

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  
  def User.generate_token
    SecureRandom.urlsafe_base64
  end
  
  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def feed
    Post.friends_posts(self)
  end
  
  def wall_feed
    WallPost.wall_posts(self)
  end
  
  private
  
  def create_auth_token
    self.auth_token = User.hash(User.generate_token)
  end
end
