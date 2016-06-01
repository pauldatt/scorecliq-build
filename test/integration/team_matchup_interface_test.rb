require 'test_helper'

class TeamMatchupInterfaceTest < ActionDispatch::IntegrationTest
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @team_match = team_matches(:team_match_a)
    @user = users(:divjot)
    log_in_as(@user)
  end
  
  test "successfully creating a team_match and @scoreboard.team_matches increases by 1" do 
    get new_scoreboard_team_match_path(@scoreboard)
      assert_difference("@scoreboard.team_matches.count", 1) do 
        post scoreboard_team_matches_path(@scoreboard), team_match: { team_a_id: "1",
                                                                      team_b_id: "2",
                                                                      match_date:  Date.parse("20160225"),
                                                                      match_time:  "22:39:02",
                                                                      location:    "abcdef", 
                                                                      score:       "abcd" }
      end                                                                
    assert_redirected_to new_scoreboard_team_match_path(@scoreboard)
  end
    
  test "UNsuccessfully creating a team_match and @scoreboard.team_matches does not change" do 
    get new_scoreboard_team_match_path(@scoreboard)
      assert_no_difference("@scoreboard.team_matches.count") do 
        post scoreboard_team_matches_path(@scoreboard), team_match: { team_a_id: "1",
                                                                      team_b_id: "2",
                                                                      match_date:  " ",
                                                                      match_time:  "22:39:02",
                                                                      location:    "abcdef", 
                                                                      score:       "abcd" }
      end                                                                
    assert_redirected_to new_scoreboard_team_match_path(@scoreboard)
  end
  
  
  
  
  
end
  

