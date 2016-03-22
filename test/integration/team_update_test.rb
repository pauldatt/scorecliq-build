require 'test_helper'

class TeamUpdatewTest < ActionDispatch::IntegrationTest
  
  def setup
    @scoreboard = scoreboards(:scoreboard_a)
    @team = teams(:team_a)
  end
  
  test 'successful updating of a team' do
      xhr :patch, scoreboard_team_path(@scoreboard, @team), team: {name: "divjdsfkn",
                                                       win: 2,
                                                       loss: 3,
                                                       tie: 4 }
      @team.reload
      assert_equal "divjdsfkn", @team.name
      assert_equal 2, @team.win
      assert_equal 3, @team.loss
      assert_equal 4, @team.tie
      assert_template 'teams/update'
      assert_template 'teams/_team'
  end
  
  test 'unsuccessful updating of a team' do
    xhr :patch, scoreboard_team_path(@scoreboard, @team), team: {name: " ",
                                                                 win: " ",
                                                                 loss: " ",
                                                                 tie: " "}
    assert_template 'teams/update_error'
    assert_template 'teams/_team_errors'
  end
  
    
end