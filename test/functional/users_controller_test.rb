require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get save_draft" do
    get :save_draft
    assert_response :success
  end

  test "should get settings" do
    get :settings
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
