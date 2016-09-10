require 'test_helper'

class TeamCreateTest < ActionDispatch::IntegrationTest
  
  def setup
    @scoreboard = scoreboards(:scoreboard_a)
    @scoreboard_e = scoreboards(:scoreboard_e)
    @scoreboard_c = scoreboards(:scoreboard_c)
    @user = users(:divjot) #divjot is unsubscribed 
    @unsub_user_3 = users(:shane)
    @sub_user = users(:sukh)
  end
  
  test 'Invalid creation of the teams' do #if it doesn't save, the create template and team errors are rendered
    log_in_as(@user)
    assert_no_difference 'Team.count' do
      xhr :post, scoreboard_teams_path(@scoreboard), team: {name: " ", 
                                                       win: 0, 
                                                       loss: 0, 
                                                       tie: 0 }
      # assert_template 'teams/create'
      assert_template 'teams/create_error'
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
  
  test "unsubscribed user CANNOT have more than 15 scoreboards" do 
    log_in_as(@unsub_user_3)
    assert_no_difference "@scoreboard_e.teams.count" do
      xhr :post, scoreboard_teams_path(@scoreboard_e), team: {name: "abc",
                                                            win: 1,
                                                            loss: 2,
                                                            tie: 2}
      assert_template 'teams/sub_create_error'                                                      
    end
    
  end
  
  test "subscribed user CAN have more than 15 scoreboards" do 
    log_in_as(@sub_user)
    assert_difference "@scoreboard_c.teams.count", 1 do
      xhr :post, scoreboard_teams_path(@scoreboard_c), team: {name: "abc",
                                                              win: 1,
                                                              loss: 2,
                                                              tie: 2}
      assert_template 'teams/create'
      assert_template 'teams/_team'                                                     
    end
  end

  # test the count must be less than 100
  
end





