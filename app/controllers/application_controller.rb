class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend

  def logged_in_user
    logged_in?
  end
end
