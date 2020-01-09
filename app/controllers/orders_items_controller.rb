class OrdersItemsController < ApplicationController
  before_action :set_orders_item, only: [:show, :edit, :update, :destroy]

  # GET /orders_items
  # GET /orders_items.json
  def index
    @orders_items = OrdersItem.all
  end

  # GET /orders_items/1
  # GET /orders_items/1.json
  def show
  end

  # GET /orders_items/new
  def new
    @orders_item = OrdersItem.new
  end

  # GET /orders_items/1/edit
  def edit
  end

  # POST /orders_items
  # POST /orders_items.json
  def create
    @orders_item = OrdersItem.new(orders_item_params)

    respond_to do |format|
      if @orders_item.save
        format.html { redirect_to @orders_item, notice: 'Orders item was successfully created.' }
        format.json { render :show, status: :created, location: @orders_item }
      else
        format.html { render :new }
        format.json { render json: @orders_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders_items/1
  # PATCH/PUT /orders_items/1.json
  def update
    respond_to do |format|
      if @orders_item.update(orders_item_params)
        format.html { redirect_to @orders_item, notice: 'Orders item was successfully updated.' }
        format.json { render :show, status: :ok, location: @orders_item }
      else
        format.html { render :edit }
        format.json { render json: @orders_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders_items/1
  # DELETE /orders_items/1.json
  def destroy
    @orders_item.destroy
    respond_to do |format|
      format.html { redirect_to orders_items_url, notice: 'Orders item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orders_item
      @orders_item = OrdersItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orders_item_params
      params.require(:orders_item).permit(:book_id, :amount, :price, :descount, :total)
    end
end
