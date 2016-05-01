class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user, :belongs_to_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:notice] = "You must be logged in to do that"
      redirect_to root_path
    end
  end

  def belongs_to_user(post)
    post.creator == User.find(session[:user_id]) if logged_in?
  end

  def set_query
    @page = params[:page] || 1
    @limit = params[:limit] || 5
    @limit = @limit.to_i
    @order_method = params[:sort_order] ? params[:sort_order].to_sym : :desc
    @offset = @page.to_i > 1 ? @limit * (@page.to_i - 1) : 0
  end



end
