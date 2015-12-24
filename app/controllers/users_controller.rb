class UsersController < ApplicationController

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
      params.require(:user).permit(:name)
    end
end
