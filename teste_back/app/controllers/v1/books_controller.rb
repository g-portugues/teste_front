module V1
  class BooksController < ApplicationController
    before_action :set_book, only: [:show, :update, :delete]

    def index
      @books = Book.all
      paginate json: @books
    end

    def show
      if @book
        render json: @book
      else
        render status: :not_found
      end
    end

    def create
      begin
        @book = Book.new(create_params)
        if @book.save
          render json: @book, status: :created
        else            
          render json: { errors: @book.errors.full_messages },
                         status: :unprocessable_entity
        end
      rescue ::Errors::InvalidParametersError => e
        render json: e.message, status: :bad_request
      end
    end

    def update
      begin
        if @book.update(update_params)
          render json: @usuario, status: :ok
        else
          render json: { errors: @book.errors.full_messages },
                         status: :unprocessable_entity
        end
      rescue ::Errors::InvalidParametersError => e
        render json: e.message, status: :bad_request
      end
    end

    def delete
      @book.destroy
    end
    
    private

      def set_book
        @book = Book.find_by_public_id(params[:id])
      end

      def create_params
        @create_params ||= begin
          raise ::Errors::InvalidParametersError.new(['book']) unless params[:book]

          params = params.require(:book).permit(:title, :price)

          unless params[:title, :price, :author_id]
            raise ::Errors::InvalidParametersError.new(
              ['title', 'price', 'author_id']
            )
          end

          params
        end
      end

      def update_params
        @update_params ||= begin          
          raise ::Errors::InvalidParametersError.new(['book']) unless params[:book]

          params.require(:book).permit(:title, :price, :author_id)
        end
      end
  end
end