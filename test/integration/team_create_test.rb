require 'test_helper'

class TeamCreateTest < ActionDispatch::IntegrationTest
  
  def setup
    @scoreboard = scoreboards(:scoreboard_a)
    @user = users(:divjot)
  end
  
  test 'Invalid creation of the teams' do #if it doesn't save, the create template and team errors are rendered
    log_in_as(@user)
    assert_no_difference 'Team.count' do
      xhr :post, scoreboard_teams_path(@scoreboard), team: {name: " ", 
                                                       win: 0, 
                                                       loss: 0, 
                                                       tie: 0 }
      assert_template 'teams/create'
      assert_template 'teams/_team_errors'
    end
  end 
  
  test 'Valid creation of the teams' do #if it does save, the team template is rendered
    log_in_as(@user)
    assert_difference "Team.count", 1 do
      xhr :post, scoreboard_teams_path(@scoreboard), team: {name: "abc",
                                                            win: 1,
                                                            loss: 2,
                                                            tie: 2}
      assert_template 'teams/create'
      assert_template 'teams/_team'
    end
  end
  

  
end





