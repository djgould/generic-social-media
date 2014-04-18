class PostsController < ApplicationController
  
  def create
    @post = current_user.posts.build(post_params)
    @post.save
    redirect_to current_user
  end
  
  def post_params
    params.require(:post).permit(:content)
  end
end
