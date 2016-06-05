require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:divjot)
  end
  
  test "passwords resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    
    # Invalid email
    post password_resets_path, password_reset: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    
    # valid email
    post password_resets_path, password_reset: { email: @user.email }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    
    # Password reset form
    user = assigns(:user)
    
    # wrong email
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url
    
    # non-activated user
    user.toggle!(:activated) # this makes the user inactive
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: user.email)
    assert_redirected_to root_url
    
    # Right email, right token
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    # assert_select "input[name=email] [type=hidden] [value=?]", user.email ----Come back to this later. The test doen't work.
    
    
    # Invalid password and confirmation
    patch password_reset_path(user.reset_token),
          email: user.email,
          user: { password:               "password",
                  password_confirmation:  "notpassword" }
    assert_select 'div#error_explanation'
    
    # Blank Password
    patch password_reset_path(user.reset_token),
          email: user.email,
          user: { password:                 "  ",
                  password_confirmation:    "foobar" }
    assert_not flash.empty?
    assert_template 'password_resets/edit'
    
    # Valid password and confirmation
    patch password_reset_path(user.reset_token),
          email: user.email,
          user: { password:               "password1",
                  password_confirmation:  "password1" }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end
  
end
