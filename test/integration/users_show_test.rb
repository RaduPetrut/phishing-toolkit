require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:george)
    @other_user = users(:cristian)
  end

  test "successful show - the correct logged-in user made the request" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert flash.empty?
  end

  
  test "unsuccessful show - the wrong logged-in user made the request" do
    log_in_as(@user)
    get user_path(@other_user)
    assert_redirected_to root_url
    follow_redirect!
    assert flash.empty?
  end

  test "unsuccessful show - the user who made the request was not logged in" do
    get user_path(@user)
    assert_redirected_to login_url
    follow_redirect!
    assert_not flash.empty?
  end

end
