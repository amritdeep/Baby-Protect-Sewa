require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get init" do
    get :init
    assert_response :success
  end

  test "should get ans" do
    get :ans
    assert_response :success
  end

  test "should get hangup" do
    get :hangup
    assert_response :success
  end

end
