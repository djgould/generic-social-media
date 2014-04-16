class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, through: :friendships, conditions: [%(status = ?), Friendship::ACCEPTED]
  has_many :requested_friend, through: :friendships, source: :friend, conditions: [%(status = ?), Friendship::REQUESTED]
  
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
