require 'test_helper'

class TeamDestroyTest < ActionDispatch::IntegrationTest
  
  def setup
    @scoreboard = scoreboards(:scoreboard_a)
    @team = teams(:team_a)
    @user = users(:divjot)
  end
  
  test "should destroy the team and decrease the count by 1" do
   log_in_as(@user)
   assert_difference("Team.count", -1) do
     xhr :delete, scoreboard_team_path(@scoreboard, @team) 
   end
     
  end
  
  
end
