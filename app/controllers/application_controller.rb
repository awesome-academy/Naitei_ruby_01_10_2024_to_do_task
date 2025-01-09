class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
  rescue_from Exception, with: :render_not_found

  private
  def render_not_found _exception
    render plain: "404 Not Found", status: :not_found
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "user.please_login"
    redirect_to login_url, status: :see_other
  end
end
