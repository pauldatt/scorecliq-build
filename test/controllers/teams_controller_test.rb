require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
    
    def setup
        @scoreboard = scoreboards(:scoreboard_a)
        @team = teams(:team_a)
    end
    
    test "should destroy teams" do
        assert_difference('Team.count', -1) do
            @team.destroy
        end
    end
    
    
end
 