require 'test_helper'

class ManagerInterfaceTest < ActionDispatch::IntegrationTest
 
 def setup 
   @user = users(:divjot)
   @scoreboard = scoreboards(:scoreboard_a)
   @scoreboard_2 = scoreboards(:scoreboard_b)
   @unsub_user = users(:dilman)
 end
 
 #posting a request for a scoreboard that has 1 admin.
 test "creating a manager increases the @scoreboard.managed_by array increases by 1" do 
   log_in_as(@user)
   assert_difference('@scoreboard.managed_by.count', 1) do
     post assign_manager_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id) 
     assert_redirected_to admins_scoreboard_path(@scoreboard)
     assert_equal "#{@user.name} was assigned as a manager", flash[:success]
   end
 end
 
 #posting a request for a scoreboard that has 2 admins, it will give you an error message.
 test "creating a manager for a scoreboard that already has 2 scoreboards should give an error message" do 
  log_in_as(@user)
   assert_no_difference('@scoreboard_2.managed_by.count') do
     post assign_manager_path(:scoreboard_id => @scoreboard_2.id, :user_id => @user.id) 
     assert_redirected_to admins_scoreboard_path(@scoreboard_2)
     assert_equal "You cannot assign more than 2 admins for a scoreboard", flash[:danger]
   end
 end
 
 #deleting a request for the user
 test "deleting a manager decreases the @scoreboard.managed_by array by 1" do 
  log_in_as(@user)
  assert_difference('@scoreboard.managed_by.count', -1) do
     delete unassign_manager_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id)
     assert_redirected_to admins_scoreboard_path(@scoreboard)
     assert_equal "#{@user.name} was removed as a manager", flash[:success]
   end
 end
 

end