class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # Save user id as cookie so they stay logged in
      session[:user_id] = user.id
      redirect_to '/'
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end