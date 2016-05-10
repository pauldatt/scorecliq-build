require 'test_helper'

class TeamUpdatewTest < ActionDispatch::IntegrationTest
  
  def setup
    @scoreboard = scoreboards(:scoreboard_a)
    @team = teams(:team_a)
    @user = users(:divjot)
  end
  
  test 'successful updating of a team' do
    log_in_as(@user)
      name = "divjdsfkn"
      win = 2
      loss = 3
      tie = 4
      xhr :patch, scoreboard_team_path(@scoreboard, @team), team: {name: name,
                                                       win: win,
                                                       loss: loss,
                                                       tie:  tie}
      @team.reload
      assert_equal name, @team.name
      assert_equal win, @team.win
      assert_equal loss, @team.loss
      assert_equal tie, @team.tie
      assert_template 'teams/update'
      assert_template 'teams/_team'
  end
  
  test 'unsuccessful updating of a team' do
    log_in_as(@user)
    xhr :patch, scoreboard_team_path(@scoreboard, @team), team: {name: " ",
                                                                 win: " ",
                                                                 loss: " ",
                                                                 tie: " "}
    assert_template 'teams/update_error'
    # assert_template 'teams/_team_errors'
  end
  
    
end