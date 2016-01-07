class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.new
    @favorite.post = @post

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to [@post.topic, @post], notice: "Favorited"}
      else
        format.html { redirect_to [@post.topic, @post], warning: "Favourite not created!"}
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by(post: @post)

    respond_to do |format|
      if @favorite.destroy
        format.html { redirect_to [@post.topic, @post], notice: "Unfavorited"}
      else
        format.html { redirect_to [@post.topic, @post], warning: "Favourite not removed!"}
      end
    end
  end

end
