class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :vote, :destroy]
  before_action :require_user, except: [:index, :show, :edit, :vote]

  def index
    @page = params[:page] || 1
    @limit = 2
    offset = @page.to_i > 1 ? @limit * (@page.to_i - 1) : 0
    @posts = Post.order(created_at: :desc).limit(@limit).offset(offset)
  end


  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    @post.creator = User.find(session[:user_id])
    if @post.save
      flash[:success] = "Your post has been saved"
      redirect_to post_path(@post)
    else
      render "new"
    end
  end

  def edit
    if current_user && !belongs_to_user(@post)
      flash[:notice] = "You don't have permission to edit that"
      redirect_to root_path
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post successfully updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end 

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    respond_to do |format|
      # format.html { redirect_to :back, notice: "Your vote has been saved"}
      format.js
    end 

  end

  def destroy
    @post.destroy
    flash[:notice] = "Post deleted"

    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit!
  end


  def set_post
    @post = Post.find_by(slug: params[:id])
  end




end
