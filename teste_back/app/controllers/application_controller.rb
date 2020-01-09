class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authorize_request

  def authorize_request
    begin
      authenticate_or_request_with_http_token do |token, options|
        @decoded = JsonWebToken.decode(token)
        @current_user = User.find_by_public_id(@decoded[:user_public_id].to_s)
        unless @current_user          
          render status: :unauthorized
          return
        end
        return
      end
    rescue JWT::ExpiredSignature
      render status: :unauthorized
    rescue JWT::DecodeError
      render status: :unauthorized
    end
  end
end
