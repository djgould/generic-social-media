class UsersController < ApplicationController
  before_filter :signed_in, only: [:index, :show]
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @friendship = Friendship.conn(current_user, @user)
    @wall_feed = @user.wall_feed
    @post = current_user.posts.build if signed_in?
    @wall_post = current_user.wall_posts.build
    if current_user == @user
      @requested_friends = current_user.requested_friends
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = 'Success!'
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
