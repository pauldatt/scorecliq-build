require 'test_helper'

class ScoreboardCreateTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:divjot) #you must let the user log in for the tests to be valid
    @scoreboard = scoreboards(:scoreboard_a)
  end
  
  test "invalid creation of the scoreboard with failing validations" do
    log_in_as(@user)
    get new_scoreboard_path
    assert_template 'scoreboards/new'
    assert_no_difference 'Scoreboard.count' do
      post scoreboards_path, scoreboard: {name_of_scoreboard: " ",
                                          name_of_organization: " ",
                                          name_of_activity: " ",
                                          scoreboard_id: " "}
      end
      assert_template 'scoreboards/new'
  end
  
  test "valid creation of the scoreboard with passing validations" do
    log_in_as(@user)
    get new_scoreboard_path
    assert_difference '@user.scoreboards.count', 1 do
      post scoreboards_path, scoreboard: {name_of_scoreboard: "abc",
                                          name_of_organization: "def",
                                          name_of_activity: "ghi",
                                          location: "mordor"}
      end
      assert_redirected_to scoreboard_path(assigns(:scoreboard)) #its redirecting to the wrong scoreboard
      assert_equal 'Scoreboard created successfully', flash[:success]
  end
  
  #just want to test staging env
    
end
