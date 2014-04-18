class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      sign_in user
      flash[:success] = 'Success'
      redirect_to user
    else
      flash.now[:error] = 'Error'
      render 'new'
    end
  end
  
  def destroy
    current_user.update_attribute(:auth_token, User.hash(User.generate_token))
    cookies.delete :auth_toke
    redirect_to sign_in_path
  end
end
