require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:divjot)
  end
  
  test "unsuccessful edits" do
    log_in_as(@user)
    get edit_user_path(@user) #when writing the test, you just write the path name to get to the designated page
    assert_template 'users/edit'
    patch user_path(@user), user: { name: '',
                                     email: 'smth@nevergonawork',
                                     password:                    'div',
                                     password_confirmation:       'vid' }
    assert_template 'users/edit'
  end
  
  test "successful edits with friendly forwarding" do
    log_in_as(@user)
    assert_redirected_to home_path # This ensures that once you log in you must assert_template of 'users/home'.
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "divjot"
    email = "divjot65@gmail.com"
    patch user_path(@user), user: {name: name,
                                   email: email,
                                   password:              "",
                                   password_confirmation: "" }
    
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
