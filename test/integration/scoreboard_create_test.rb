require 'test_helper'

class ScoreboardCreateTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:divjot) #you must let the user log in for the tests to be valid
    @unsub_user = users(:sherbie) #sukh is not subscribed and has one scoreboard
    @scoreboard = scoreboards(:scoreboard_a) 
    @unsub_user_2 = users(:dilman)
    @sub_user = users(:sukh)
  end
  
  
  test "invalid creation of the scoreboard with failing validations with an unsub_user" do
    log_in_as(@unsub_user)
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
  
  test "valid creation of the scoreboard with passing validations with a unsub_user" do
    log_in_as(@unsub_user)
    get new_scoreboard_path
    assert_difference '@unsub_user.scoreboards.count', 1 do
      post scoreboards_path, scoreboard: {name_of_scoreboard: "abc",
                                          name_of_organization: "def",
                                          name_of_activity: "ghi",
                                          location: "mordor"}
      end
      assert_redirected_to scoreboard_path(assigns(:scoreboard)) #its redirecting to the wrong scoreboard
      assert_equal 'Scoreboard created successfully', flash[:success]
  end
  
  test "unsub_user fails to create more than one scoreboard" do 
    log_in_as(@unsub_user_2)
    get new_scoreboard_path
    assert_no_difference '@unsub_user_2.scoreboards.count' do
      post scoreboards_path, scoreboard: {name_of_scoreboard: "abc",
                                          name_of_organization: "def",
                                          name_of_activity: "ghi",
                                          location: "mordor"}
      end
      assert_redirected_to new_scoreboard_path #its redirecting to the wrong scoreboard
      assert_equal 'You must be subscribed to own more than 1 league page.', flash[:danger]
  end
  
  test "subscribed user successfully creates a scoreboard" do 
    log_in_as(@sub_user)
    get new_scoreboard_path
    assert_difference '@sub_user.scoreboards.count', 1 do
      post scoreboards_path, scoreboard: {name_of_scoreboard: "abc",
                                          name_of_organization: "def",
                                          name_of_activity: "ghi",
                                          location: "mordor"}
      end
    assert_redirected_to scoreboard_path(assigns(:scoreboard))
    assert_equal 'Scoreboard created successfully', flash[:success]
  end
    
end
