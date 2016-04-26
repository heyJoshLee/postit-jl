class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Your post has been saved"
      redirect_to post_path(@post)
    else
      render "new"
    end
  end

  def post_params
    params.require(:post).permit!
  end
end
