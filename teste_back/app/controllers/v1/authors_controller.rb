module V1
  class AuthorsController < ApplicationController
    before_action :set_author, only: [:show, :update, :delete]

    def index
      @authors = Author.all
      paginate json: @authors
    end

    def show
      if @author
        render json: @author
      else
        render status: :not_found
      end
    end

    def create
      begin
        @author = Author.new(create_params)
        if @author.save
          render json: @author, status: :created
        else            
          render json: { errors: @author.errors.full_messages },
                       status: :unprocessable_entity
        end
      rescue ::Errors::InvalidParametersError => e
        render json: e.message, status: :bad_request
      end
    end

    def update
      begin
        if @author.update(update_params)
          render json: @author, status: :ok
        else
          render json: { errors: @author.errors.full_messages },
                status: :unprocessable_entity
        end
      rescue ::Errors::InvalidParametersError => e
        render json: e.message, status: :bad_request
      end
    end

    def delete
      @author.destroy
    end
    
    private

      def set_author
        @author = Author.find_by_public_id(params[:id])
      end

      def create_params
        @create_params ||= begin          
          raise ::Errors::InvalidParametersError.new(['author']) unless params[:author]

          params = params.require(:author).permit(:name)

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
          raise ::Errors::InvalidParametersError.new(['author']) unless params[:author]

          params.require(:author).permit(:name)
        end
      end
  end
end