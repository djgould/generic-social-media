class StaticPagesController < ApplicationController
  before_filter :signed_in
  def home
    @feed = current_user.feed
    @post = current_user.posts.build
  end
end
