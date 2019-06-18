require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase

  include ActiveJob::TestHelper
  test "cheque routing number" do

    LineItem.delete_all
    Order.delete_all
    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'Tanushree Marwah'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'tanushree@gmail.com'

    assert_no_selector "#order_routing_number"

    select 'Cheque', from: 'pay_type'

    assert_selector "#order_routing_number"
    fill_in "Routing #", with: "123456"
    fill_in "Account #", with: "987654"

    perform_enqueued_jobs do
      click_button "Place Order"
    end

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal "Tanushree Marwah", order.name
    assert_equal "123 Main Street", order.address
    assert_equal "tanushree@gmail.com", order.email
    assert_equal "Cheque", order.pay_type
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["tanushree@gmail.com"], mail.to
    assert_equal 'Tanushree Ruby <depot@example.com>', mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject

  end

  # test "cheque account number" do
    # ...
    # assert_no_selector "#order_account_number"
    # ...
  # end
 
  test "credit card cc number" do
    visit store_index_url

    first('.catalog li').click_on 'Add to Cart'
    click_on 'Checkout'

    fill_in 'order_name', with: 'Tanushree Marwah'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'tanushree@gmail.com'

    assert_no_selector "#order_cc_number"

    select 'Credit Card', from: 'pay_type'

    assert_selector "#order_cc_number"
  end

  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    fill_in "Pay type", with: @order.pay_type
    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Pay type", with: @order.pay_type
    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end