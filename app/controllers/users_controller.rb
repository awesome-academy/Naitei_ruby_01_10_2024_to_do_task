class UsersController < ApplicationController
  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "user.please_check_your_mail"
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(User::USER_PERMITTED_ATTRIBUTES)
  end

  def set_user
    @user = User.find params[:id]
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "user.please_login"
    redirect_to login_url, status: :see_other
  end

  def correct_user
    redirect_to(root_url, status: :see_other) unless current_user? @user
  end
end
