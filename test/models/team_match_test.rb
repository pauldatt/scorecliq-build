require 'test_helper'

class TeamMatchTest < ActiveSupport::TestCase
    
    def setup 
     @scoreboard = scoreboards(:scoreboard_a)
     @user = users(:divjot)
     @team_match = @scoreboard.team_matches.build(match_date: Date.parse("20160225"), match_time: "2016-04-15 01:17:05", location: "mystring", score: "mystring", team_a_id: 1, team_b_id: 2)
    end
    
    test "team_match valid" do 
        assert @team_match.valid?
    end
    
    
    test "match date must be present" do 
        @team_match.match_date = " "
        assert_not @team_match.valid?
    end
    
    test "team_a must be present" do 
        @team_match.team_a_id = " "
        assert_not @team_match.valid?
    end
    
    test "team_b must be present" do 
        @team_match.team_b_id = " "
        assert_not @team_match.valid?
    end
 
end


