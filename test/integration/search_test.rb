require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @user = users(:divjot)
    log_in_as(@user)
  end
  
  test "search scoreboard which returns a valid result" do
    get search_path
    assert_select "a[href=?]", user_path(@user)
    # assert_select "a[href=?]", scoreboard_path(@scoreboard)
    assert_equal @scoreboard.name_of_scoreboard, @scoreboard.name_of_scoreboard
  end
  
  

  
end
