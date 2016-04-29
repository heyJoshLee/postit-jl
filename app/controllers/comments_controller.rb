class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.creator = User.find(session[:user_id])

    if @comment.save
      flash[:notice] = "Comment Saved"
      redirect_to post_path(@post)
    else
      render "posts/show"
    end


  end

  private

  def comment_params
    params.require(:comment).permit!
  end

end