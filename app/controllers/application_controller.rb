class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
end
