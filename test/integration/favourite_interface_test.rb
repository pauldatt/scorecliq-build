require 'test_helper'

class FavouriteInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:sukh)
    @scoreboard = scoreboards(:scoreboard_b)
    log_in_as(@user)
  end
  
  test "user should favourite a scoreboard" do 
    assert_difference('@user.favourite_scoreboards.count', 1) do 
      post favourite_scoreboard_path(@scoreboard, type: "favourite")
      assert_redirected_to @scoreboard
      assert_equal "You followed scoreboard: #{@scoreboard.name_of_scoreboard}", flash[:success]
    end
  end
  
  test 'user associated with the scoreboard count should increase by 1' do
    assert_difference('@scoreboard.favourited_by.count', 1) do
      post favourite_scoreboard_path(@scoreboard, type: "favourite")
    end
  end
  
  test 'user should UNfavourite a scoreboard' do
    assert_difference('@user.favourite_scoreboards.count', 0) do
      delete favourite_scoreboard_path(@scoreboard, type: "unfavourite")
      assert_redirected_to @scoreboard
      assert_equal "You unfollowed scoreboard: #{@scoreboard.name_of_scoreboard}", flash[:success]
    end
  end
  
  test 'user associated with the scoreboard count should decrease by 1' do
    assert_difference('@user.favourite_scoreboards.count', 0) do
      delete favourite_scoreboard_path(@scoreboard, type: "unfavourite")
    end
  end
  
  test 'user unfollowing a scoreboard on user-index' do
    assert_difference('@user.favourite_scoreboards.count', 0) do
      delete favourite_scoreboard_path(@scoreboard, type: "unfav-index")
      assert_redirected_to scoreboards_path
      assert_equal "You unfollowed scoreboard: #{@scoreboard.name_of_scoreboard}", flash[:success]
    end
  end
  
  
end
