class UsersController < ApplicationController
  before_action :authenticated_user, except: [:show]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user).paginate(page: params[:page])
    @comments = @user.comments.paginate(page: params[:page])
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = "User updated"
      redirect_to edit_user_registration_path
    else
      flash[:danger] = "There was a problem updating your details. Please try again!"
      redirect_to edit_user_registration_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :avatar, :email_favorites)
    end
end
