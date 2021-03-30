class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  include JwtAuthenticator
  before_action :jwt_authenticate
end
