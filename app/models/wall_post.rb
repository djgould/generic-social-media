class WallPost < Post
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: 'friend_id'
  
  validates :content, presence: true, length: { maximum: 200 }
  validates :friend_id, presence: true
end
