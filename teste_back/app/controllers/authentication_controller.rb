module Integradores
  module V1
    class AuthenticationController < ApplicationController
      include ActionController::HttpAuthentication::Basic::ControllerMethods

      skip_before_action :authorize_request, only: :login
      skip_authorize_resource only: [:login]

      # POST /auth/login
      def login
        authenticate_with_http_basic do |email, password|
          usuario = Usuario.find_by_email(email)
          unless usuario && usuario.authenticate(password)
            render status: :unauthorized
            return
          end
          token, exp = JsonWebToken.encode({
            usuario_public_id: usuario.public_id
          })
          render json: {
            token: token,
            exp: Time.zone.at(exp).to_datetime
          }, status: :ok
          return
        end
        render status: :bad_request
      end
    end
  end
end