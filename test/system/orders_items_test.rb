require "application_system_test_case"

class OrdersItemsTest < ApplicationSystemTestCase
  setup do
    @orders_item = orders_items(:one)
  end

  test "visiting the index" do
    visit orders_items_url
    assert_selector "h1", text: "Orders Items"
  end

  test "creating a Orders item" do
    visit orders_items_url
    click_on "New Orders Item"

    fill_in "Amount", with: @orders_item.amount
    fill_in "Book", with: @orders_item.book_id
    fill_in "Descount", with: @orders_item.descount
    fill_in "Price", with: @orders_item.price
    fill_in "Total", with: @orders_item.total
    click_on "Create Orders item"

    assert_text "Orders item was successfully created"
    click_on "Back"
  end

  test "updating a Orders item" do
    visit orders_items_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @orders_item.amount
    fill_in "Book", with: @orders_item.book_id
    fill_in "Descount", with: @orders_item.descount
    fill_in "Price", with: @orders_item.price
    fill_in "Total", with: @orders_item.total
    click_on "Update Orders item"

    assert_text "Orders item was successfully updated"
    click_on "Back"
  end

  test "destroying a Orders item" do
    visit orders_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Orders item was successfully destroyed"
  end
end
