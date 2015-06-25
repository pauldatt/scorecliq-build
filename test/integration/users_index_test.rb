require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin     = users(:divjot)
    @non_admin = users(:sukh)
  end
  
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1) # you store the user.paginate(page:1) in variable first_page_of_users
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'Delete user',
                                                      method: :delete
      end
    end
  
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin) 
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin) do
      get users_path
      assert_select 'a', text: 'Delete user', count: 0 # This ensures that the link 'Delete user' does not appear and has a count zero
    end
end

end
