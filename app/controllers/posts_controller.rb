class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show, :edit, :vote]

  def index
    @posts = Post.all
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

  private

  def post_params
    params.require(:post).permit!
  end


  def set_post
    @post = Post.find(params[:id])
  end




end
