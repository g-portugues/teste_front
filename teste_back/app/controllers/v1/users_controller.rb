module V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :delete]

    def index
      @users = User.all
      paginate json: @users
    end

    def show
      if @user
        render json: @user
      else
        render status: :not_found
      end
    end

    def create
      begin
        @user = User.new(create_params)
        if @user.save
          render json: @user, status: :created
        else            
          render json: { errors: @user.errors.full_messages },
                       status: :unprocessable_entity
        end
      rescue ::Errors::InvalidParametersError => e
        render json: e.message, status: :bad_request
      end
    end

    def update
      begin
        if @user.update(update_params)
          render json: @user, status: :ok
        else
          render json: { errors: @user.errors.full_messages },
                 status: :unprocessable_entity
        end
      rescue ::Errors::InvalidParametersError => e
        render json: e.message, status: :bad_request
      end
    end

    def delete
      @user.destroy
    end
    
    private

      def set_user
        @user = User.find_by_public_id(params[:id])
      end

      def create_params
        @create_params ||= begin          
          raise ::Errors::InvalidParametersError.new(['user']) unless params[:user]

          params = params.require(:user).permit(:name, :email, :password, :password_confirmation)

          unless params[:name] &&
                 params[:email] &&
                 params[:password] &&
                 params[:password_confirmation]
            raise ::Errors::InvalidParametersError.new(
              ['name', 'email', 'password', 'password_confirmation']
            )
          end

          params
        end
      end

      def update_params
        @update_params ||= begin          
          raise ::Errors::InvalidParametersError.new(['user']) unless params[:user]

          params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
      end
  end
end