require 'test_helper'

class WebControllerTest < ActionController::TestCase
  test "should get splash" do
    get :splash
    assert_response :success
  end

end
