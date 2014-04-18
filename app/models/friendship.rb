class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: 'friend_id'
  validates :user_id, :friend_id, presence: true
  
  #status codes
  ACCEPTED = 0
  REQUESTED = 1
  PENDING = 2
  
  def accept
    Friendship.accept(user_id, friend_id)
  end
  
  def unfriend
    Friendship.unfriend(user_id, friend_id)
  end
  
  class << self
    def exists?(user, friend)
      not conn(user, friend).nil?
    end
    
    def request(user, friend)
      transaction do
        create!(user: user, friend: friend, status: PENDING)
        create!(user: friend, friend: user, status: REQUESTED)
      end
    end
    
    def accept(user, friend)
      transaction do
        accepted_at = Time.now
        conn(user, friend).update_attributes(status: ACCEPTED, accepted_at: accepted_at)
        conn(friend, user).update_attributes(status: ACCEPTED, accepted_at: accepted_at)
      end
    end
    
    def unfriend(user, friend)
      transaction do
        destroy(conn(user, friend))
        destroy(conn(friend, user))
      end
    end
    
    def conn(user, friend)
      find_by_user_id_and_friend_id(user, friend)
    end
  end
end
