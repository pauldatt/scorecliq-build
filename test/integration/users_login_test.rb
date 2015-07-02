require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:divjot)
  end
  
  test "login with invalid information" do
    get root_path
    assert_template 'static_pages/home'
    post login_path, session: { email: "", password: "" }
    assert_template 'static_pages/home'
    assert_not flash.empty?
    get signup_path
    assert flash.empty?
  end
  
  test "login with valid information followed by logout" do
    get root_path
    assert_template 'static_pages/home'
    post login_path, session: { email: @user.email, password: 'password' }
    
    
    assert is_logged_in?
    assert_template 'users/home' # The code is "render "users/home", therefore, I am testing for rendering a template.
    assert_select "a[href=?]", users_path #Index
    assert_select "a[href=?]", user_path(@user) #update
    assert_select "a[href=?]", login_path, count: 0 #creates sessions
    assert_select "a[href=?]", logout_path #destroys sessions
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window
    delete logout_path
    follow_redirect!
    # assert_select "a[href=?]", login_path # come back to this test later
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  
  test "login with checking remember" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end
  
  test 'login without checking remember' do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
  
 
