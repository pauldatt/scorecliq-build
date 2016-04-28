require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @user = users(:divjot)
  end
  
  test "search scoreboard which returns a valid result" do
    get search_path
    get search_path, search: { search: @scoreboard.name_of_scoreboard}
    assert_select "a[href=?]", scoreboard_path
    # assert_select "a[href=?]", user_path(@scoreboard.user)
    
    
  end
  
  
  
  
end
