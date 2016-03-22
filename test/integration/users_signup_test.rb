require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "Invalid sign-up submission" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: " ",
                               email: "invalid@user",
                               password: "123",
                               password_confirmation: "456" }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  
  test "valid sign-up information with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user:       {name: "Divjot",
                                    email: "Divjot@gmail.com",
                                    password: "123456",
                                    password_confirmation: "123456"}
    end
    
    
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    
    #This tries to log in before activation
    log_in_as(user)
    assert_not is_logged_in?
    
    # This produces invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    
    #Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'static_pages/home'
    assert is_logged_in?
  end
end