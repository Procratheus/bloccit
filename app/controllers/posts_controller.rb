class PostsController < ApplicationController
  before_action :flash_attack

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
      flash[:notice] = "Your new post was succesfully created"
      redirect_to @post
    else
      flash[:error] = "There was a problem saving your post. Please try again!"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

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

    def flash_attack
      flash[:notice] = "This is a flash attack"
    end

end
