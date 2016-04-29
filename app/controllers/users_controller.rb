class UsersController < ApplicationController

  before_action :require_user, except: [:show, :new, :create]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show
  end

  def edit
    if current_user != @user
      flash[:notice] = "You do not have permission to edit this page"
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notce] = "You are now signed up!"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User successfully updated"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end 

  private

  def user_params
    params.require(:user).permit!
  end

  def set_user
    @user = User.find(params[:id])
  end

end