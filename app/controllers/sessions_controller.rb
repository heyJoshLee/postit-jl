class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      flash[:notice] = "You are now logged in"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:notice] = "Something is wrong with your username or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are now logged out"
    redirect_to root_path
  end

end