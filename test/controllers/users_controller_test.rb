require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user =        users(:divjot)
    @second_user = users(:sukh)
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_template 'static_pages/home'
  end
  
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_template 'static_pages/home'
  end
  
  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_template 'static_pages/home' # This test makes sure the template static_pages/home is rendered.
  end
  
  test "should redirect the edit page to root path when logged in as wrong user" do
    log_in_as(@second_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect the update page to root path when logged in as a wrong user" do
    log_in_as(@second_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect destroy action when user not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_template 'static_pages/home'
  end
  
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@second_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end
  
end
