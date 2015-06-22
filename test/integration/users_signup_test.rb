require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "Invalid sign-up submission" do
    assert_no_difference 'User.count' do
      post users_path, user: { name: " ",
                               email: "invalis@user",
                               password: "123",
                               password_confirmation: "456" }
    assert_template 'users/new'
  end
end
  
  test "valid sign-up submission test" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {name: "Divjot",
                                    email: "Divjot@gmail.com",
                                    password: "123456",
                                    password_confirmation: "123456"}
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
end