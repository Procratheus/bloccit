class PostsController < ApplicationController

  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.new(post_params)
    @post.topic = @topic
    @post.user = current_user
    authorize @post
    if @post.save
      flash[:notice] = "Your new post was succesfully created"
      redirect_to [@topic, @post]
    else
      flash[:danger] = "There was a problem saving your post. Please try again!"
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post

    if @post.update(post_params)
      flash[:notice] = "Your post was succesfully updated!"
      redirect_to [@topic, @post]
    else
      flash[:danger] = "There was an error updating your post. Please try again!"
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post

    if @post.destroy
      flash[:notice] = "Your post was succesfully deleted!"
      redirect_to @topic
    else
      flash[:danger] = "There was an error deleting your post. Please try again!"
      redirect_to @post
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

end
