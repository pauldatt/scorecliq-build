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
  
  test "successful edits with friendl forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "divjot"
    email = "divjot@example.com"
    patch user_path(@user), user: {name: name,
                                   email: email,
                                   password:              "",
                                   password_confirmation: "" }
    
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end
