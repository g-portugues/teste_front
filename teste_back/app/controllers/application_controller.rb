class ApplicationController < ActionController::API
  def authorize_request
    before_action :authorize_request
    begin
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      @decoded = JsonWebToken.decode(header)
      @current_user = Usuario.find_by_public_id(@decoded[:usuario_public_id].to_s)
      unless @current_user
        render status: :unauthorized
        return
      end
      @garagem = @current_user.garagens.last
    rescue JWT::ExpiredSignature => e
      render status: :unauthorized
    rescue JWT::DecodeError => e
      render status: :unauthorized
    end
  end
end
