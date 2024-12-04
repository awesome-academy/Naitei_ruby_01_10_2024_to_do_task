class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      forwarding_url = session[:forwarding_url]
      reset_session

      if params[:session][:remember_me] == "1"
        remember(user)
      else
        forget(user)
      end

      log_in user
      redirect_to forwarding_url || root_url
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path, status: :see_other
  end
end
