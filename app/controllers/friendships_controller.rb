class FriendshipsController < ApplicationController
  def create
    other_user = User.find(params[:id])
    Friendship.request(current_user, other_user)
  end

  def destroy
    other_user = User.find(params[:id])
    if Friendship.exists?(current_user, other_user)
      friendship = Friendship.conn(current_user, other_user)
      friendship.unfriend
    end
  end
  
  def accept
    other_user = User.find(params[:id])
    if Friendship.exists?(current_user, other_user)
      friendship = Friendship.conn(current_user, other_user)
      friendship.accept
    end
  end
end
