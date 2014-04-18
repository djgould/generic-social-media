class FriendshipsController < ApplicationController
  before_filter :authorize_user, only: [:edit, :update]
  
  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end
  
  def create
    other_user = User.find(params[:user_id])
    Friendship.request(current_user, other_user)
    redirect_to other_user
  end

  def edit
    @friendship = Friendship.find(params[:id])
    @requested_friend = @friendship.friend
  end
  
  def update
    friendship = Friendship.find(params[:id])
    case params[:commit]
    when "Accept"
      friendship.accept
    when "Decline"
      friendship.unfriend
    end
    redirect_to current_user
  end

  def destroy
    other_user = User.find(params[:user_id])
    if Friendship.exists?(current_user, other_user)
      friendship = Friendship.conn(current_user, other_user)
      friendship.unfriend
    end
  end
  
  def authorize_user
    @friendship = Friendship.find(params[:id])
    unless @friendship.status == Friendship::REQUESTED and @friendship.user == current_user
      flash[:error] = 'Not Authorized'
      redirect_to current_user
    end
  end
end