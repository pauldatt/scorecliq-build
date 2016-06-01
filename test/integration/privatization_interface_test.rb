require 'test_helper'

class PrivatizationInterfaceTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:divjot)
    @scoreboard = scoreboards(:scoreboard_a)
    @scoreboardb = scoreboards(:scoreboard_b)
    log_in_as(@user)
  end

  test "user successfully makes a scoreboard private" do 
    put private_path(:scoreboard_id => @scoreboard.id), scoreboard: {privatization: "true"}
    @scoreboard.reload
    assert_equal true, @scoreboard.privatization
    assert_equal "The scoreboard #{@scoreboard.name_of_scoreboard} is now private", flash[:success]
    assert_redirected_to @scoreboard
  end
  
  test 'user successfully makes a scoreboard public' do 
    put unprivate_path(:scoreboard_id => @scoreboardb.id), scoreboard: {privatization: "false"}
    @scoreboardb.reload
    assert_equal false, @scoreboardb.privatization
    assert_equal "The scoreboard #{@scoreboardb.name_of_scoreboard} is now public", flash[:success]
    assert_redirected_to @scoreboardb
  end

end