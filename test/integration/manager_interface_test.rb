require 'test_helper'

class ManagerInterfaceTest < ActionDispatch::IntegrationTest
 
 def setup 
   @user = users(:divjot)
   @scoreboard = scoreboards(:scoreboard_a)
   @manager = managers(:manager_a)
   log_in_as(@user)
 end
 
 test "creating a manager increases the @scoreboard.managed_by array increases by 1" do 
   assert_difference('@scoreboard.managed_by.count', 1) do
     post assign_manager_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id) 
     assert_redirected_to @scoreboard
     assert_equal "#{@user.name} was assigned as a manager", flash[:notice]
   end
 end
 
 test "deleting a manager decreases the @scoreboard.managed_by array by 1" do 
  assert_difference('@scoreboard.managed_by.count', -1) do
     delete unassign_manager_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id)
     assert_redirected_to @scoreboard 
     assert_equal "#{@user.name} was deleted as a manager", flash[:notice]
   end
end
 
end
