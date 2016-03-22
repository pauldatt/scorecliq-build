require 'test_helper'

class TeamsEditTest < ActionDispatch::IntegrationTest
  
  def setup
      @scoreboard = scoreboards(:scoreboard_a)
      @team = teams(:team_a)
  end
  
  test "should render edit template" do
      xhr :get, edit_scoreboard_team_path(@scoreboard, @team)
      assert_template "teams/_teamedit"
      assert_template 'teams/_teamsform'
      assert_template "teams/edit"
  end
    
    
  
end
