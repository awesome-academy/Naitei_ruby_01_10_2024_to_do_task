class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    return unless user&.authenticate params[:session][:password]

    handle_remember_me(user)
    log_in user
    forwarding_url = session[:forwarding_url]
    redirect_to forwarding_url || root_url
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t "user.logout_successfully"
    redirect_to login_path, status: :see_other
  end

  private

  def handle_remember_me user
    reset_session
    if params[:session][:remember_me] == "1"
      remember(user)
    else
      forget(user)
    end
  end
end
