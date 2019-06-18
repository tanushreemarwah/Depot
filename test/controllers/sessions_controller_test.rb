require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sessions_new_url
    assert_response :success
  end

  test "should get create" do
    get sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get sessions_destroy_url
    assert_response :success
  end

  test "should prompt login" do
    get login_url
    assert_response :success
  end

  test "should login" do 
    tanushree = users(:one)
    post login_url, params: {name: tanushree.name, password: 'secret'}
    assert_redirected_to admin_url
    assert_equal tanushree.id, session[:user_id]
  end

  def "should fail login" do
    tanushree = users(:one)
    post login_url, params: { name: tanushree.name, password: 'wrong'}
    assert_redirected_to login_url
  end

  def "should logout" do
    delete login_url
    assert_redirected_to store_index_url
  end 
end
