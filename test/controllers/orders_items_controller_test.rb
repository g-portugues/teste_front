require 'test_helper'

class OrdersItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @orders_item = orders_items(:one)
  end

  test "should get index" do
    get orders_items_url
    assert_response :success
  end

  test "should get new" do
    get new_orders_item_url
    assert_response :success
  end

  test "should create orders_item" do
    assert_difference('OrdersItem.count') do
      post orders_items_url, params: { orders_item: { amount: @orders_item.amount, book_id: @orders_item.book_id, descount: @orders_item.descount, price: @orders_item.price, total: @orders_item.total } }
    end

    assert_redirected_to orders_item_url(OrdersItem.last)
  end

  test "should show orders_item" do
    get orders_item_url(@orders_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_orders_item_url(@orders_item)
    assert_response :success
  end

  test "should update orders_item" do
    patch orders_item_url(@orders_item), params: { orders_item: { amount: @orders_item.amount, book_id: @orders_item.book_id, descount: @orders_item.descount, price: @orders_item.price, total: @orders_item.total } }
    assert_redirected_to orders_item_url(@orders_item)
  end

  test "should destroy orders_item" do
    assert_difference('OrdersItem.count', -1) do
      delete orders_item_url(@orders_item)
    end

    assert_redirected_to orders_items_url
  end
end
