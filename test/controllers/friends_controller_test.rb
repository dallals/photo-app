require 'test_helper'

class FriendsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get destory" do
    get :destory
    assert_response :success
  end

end
