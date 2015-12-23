class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = current_user.posts.new(post_params)
    authorize @post
    if @post.save
      flash[:notice] = "Your new post was succesfully created"
      redirect_to @post
    else
      flash[:error] = "There was a problem saving your post. Please try again!"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post

    if @post.update(post_params)
      flash[:notice] = "Your post was succesfully updated!"
      redirect_to @post
    else
      flash[:error] = "There was an error updating your post. Please try again!"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post

    if @post.destroy
      flash[:notice] = "Your post was succesfully deleted!"
      redirect_to @posts
    else
      flash[:error] = "There was an error deleting your post. Please try again!"
      redirect_to @post
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

end
