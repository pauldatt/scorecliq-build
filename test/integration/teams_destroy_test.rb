require 'test_helper'

class TeamsDestroyTest < ActionDispatch::IntegrationTest
  
  def setup
    @scoreboard = scoreboards(:scoreboard_a)
    @team = teams(:team_a)
  end
  
  test "should destroy the team and decrease the count by 1" do
   assert_difference("Team.count", -1) do
     xhr :delete, scoreboard_team_path(@scoreboard, @team) 
   end
     
  end
  
  
end
