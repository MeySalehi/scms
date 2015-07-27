require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get page" do
    get :page
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get category" do
    get :category
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

end
