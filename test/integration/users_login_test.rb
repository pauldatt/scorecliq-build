require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:divjot)
  end
  
  test "login with invalid information" do
    get root_path
    assert_template 'static_pages/home'
    post login_path, session: { email: "", password: "" }
    assert_redirected_to root_path
    assert_not flash.empty?
    get signup_path
    assert_not flash.empty?
  end
  
  test "login with valid information followed by logout" do
    get root_path
    assert_template 'static_pages/home'
    post login_path, session: { email: @user.email, password: 'password1' }
    
    
    assert is_logged_in?
    assert_redirected_to home_path # The code is "render "users/home", therefore, I am testing for rendering a template.
    follow_redirect! # after the login, you must follow the redirect, below we check for links
    assert_select "a[href=?]", home_path
    assert_select "a[href=?]", user_path(@user) #users show page
    assert_select "a[href=?]", login_path, count: 0 #creates sessions
    assert_select "a[href=?]", logout_path #destroys sessions
    assert_select "a[href=?]", search_path # search_path
    assert_select "a[href=?]", edit_user_path(@user) # changings setting for the user
    # assert_select "a[href=?]", conversations_path #conversation_path
    delete logout_path # the code below simulates a user clicking logout
    assert_not is_logged_in?
    assert_redirected_to root_url # Simulates a user clicking logout in a second window
    delete logout_path
    follow_redirect!
    assert_template 'sessions/_loginform' #this displays the login_form partial
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  
  test "login with checking remember" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token'] # cookie isn't nil (remembered)
  end
  
  test 'login without checking remember' do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token'] # cookie is nil (not remembered)
  end
end
  
 
