class WallPostsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    wallpost = current_user.wall_posts.build(content: params[:wall_post][:content], friend_id: user.id)
    wallpost.save!
    redirect_to user
  end
  
  def wall_post_params
    params.require(:wall_post).permit(:content, friend_id: :user_id)
  end
end
