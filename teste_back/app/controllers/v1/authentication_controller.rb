module V1
  class AuthenticationController < ApplicationController
    include ActionController::HttpAuthentication::Basic::ControllerMethods

    skip_before_action :authorize_request, only: :login
    # skip_authorize_resource only: [:login]

    # POST /auth/login
    def login
      authenticate_with_http_basic do |email, password|
        user = User.find_by_email(email)
        unless user && user.authenticate(password)
          render status: :unauthorized
          return
        end
        token, exp = JsonWebToken.encode({
          user_public_id: user.public_id
        })
        render json: {
          access_token: token,
          exp: Time.zone.at(exp).to_datetime
        }, status: :ok
        return
      end
      render status: :bad_request
    end
  end
end