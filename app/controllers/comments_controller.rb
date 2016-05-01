class CommentsController < ApplicationController

  before_action :set_post, only: [:create]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.creator = User.find(session[:user_id])

    if @comment.save
      flash[:notice] = "Comment Saved"
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    respond_to do |format|
      # format.html { redirect_to :back, notice: "Your vote has been saved"}
      format.js
    end 

  end

  def destroy
    @comment  = Comment.find(params[:id])
    
    @comment.destroy
    
    flash[:notice] = "Comment deleted"

    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit!
  end

  private

  def set_post
    @post = Post.find_by(slug: params[:post_id])
  end

end