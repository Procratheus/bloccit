class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    authorize @comment

    if @comment.save
      flash[:notice] = "Comment saved"
      redirect_to [@post.topic, @post]
    else
      flash[:danger] = "There was a problem saving your comment. Please try again!"
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment deleted."
      redirect_to [@post.topic, @post]
    else
      flash[:danger] = "There was a problem deleting your post. Please try again!"
      redirect_to [@post.topic, @post]
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
