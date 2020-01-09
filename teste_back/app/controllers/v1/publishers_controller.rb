module V1
  class PublishersController < ApplicationController
    before_action :set_publisher, only: [:show, :update, :delete]

    def index
      @publishers = Publisher.all
      paginate json: @publishers
    end

    def show
      if @publisher
        render json: @publisher
      else
        render status: :not_found
      end
    end

    def create
      begin
        @publisher = Publisher.new(create_params)
        if @publisher.save
          render json: @publisher, status: :created
        else            
          render json: { errors: @publisher.errors.full_messages },
                 status: :unprocessable_entity
        end
      rescue ::Errors::InvalidParametersError => e
        render json: e.message, status: :bad_request
      end
    end

    def update
      begin
        if @publisher.update(update_params)
          render json: @publisher, status: :ok
        else
          render json: { errors: @publisher.errors.full_messages },
                status: :unprocessable_entity
        end
      rescue ::Errors::InvalidParametersError => e
        render json: e.message, status: :bad_request
      end
    end

    def delete
      @publisher.destroy
    end
    
    private

      def set_publisher
        @publisher = Publisher.find_by_public_id(params[:id])
      end

      def create_params
        @create_params ||= begin
          raise ::Errors::InvalidParametersError.new(['publisher']) unless params[:publisher]

          params = params.require(:publisher).permit(:name)

          unless params[:name]
            raise ::Errors::InvalidParametersError.new(
              ['name']
            )
          end

          params
        end
      end

      def update_params
        @update_params ||= begin          
          raise ::Errors::InvalidParametersError.new(['publisher']) unless params[:publisher]

          params.require(:publisher).permit(:name)
        end
      end
  end
end