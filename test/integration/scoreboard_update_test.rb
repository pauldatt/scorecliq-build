require 'test_helper'

class ScoreboardUpdateTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:divjot)
    @second_user = users(:sukh)
    @scoreboard = scoreboards(:scoreboard_a)
  end
  
  test "unsuccessfull updating of the scoreboard" do
    log_in_as(@user) # @user is the correct user, he is the one associated with the user
    assert_redirected_to home_path
    get edit_scoreboard_path(@scoreboard) #this also tests the scoreboard edit test, the correct template is being rendered
    assert_template 'scoreboards/edit'
    patch scoreboard_path(@scoreboard), scoreboard: { name_of_scoreboard: "a"* 51,
                                                      name_of_organization: "b"*60,
                                                      name_of_activity: "c"*60,
                                                      scoreboard_id: " "}
    assert_template 'scoreboards/edit'
  end
    
                                                    
  
  
  test "successful updating of the scoreboard" do
    log_in_as(@user)
    get edit_scoreboard_path(@scoreboard)
    assert_template 'scoreboards/edit'
    name_of_scoreboard = "abc"
    name_of_organization = "def"
    name_of_activity = "ghi"
    patch scoreboard_path(@scoreboard), scoreboard: { name_of_scoreboard: name_of_scoreboard,
                                                      name_of_organization: name_of_organization,
                                                      name_of_activity: name_of_activity }
    assert_not flash.empty?
    assert_redirected_to @scoreboard
    @scoreboard.reload
    assert_equal name_of_scoreboard, @scoreboard.name_of_scoreboard
    assert_equal name_of_activity, @scoreboard.name_of_activity
    assert_equal name_of_organization, @scoreboard.name_of_organization
  end
end
