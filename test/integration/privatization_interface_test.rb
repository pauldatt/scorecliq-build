require 'test_helper'

class PrivatizationInterfaceTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:divjot)
    @scoreboard = scoreboards(:scoreboard_a)
    log_in_as(@user)
  end

  test "user successfully makes a scoreboard private" do 
    put private_path(:scoreboard_id => @scoreboard.id), scoreboard: {privatization: "true"}
    @scoreboard.reload
    assert_equal true, @scoreboard.privatization
    assert_equal "The scoreboard #{@scoreboard.name_of_scoreboard} is now private", flash[:notice]
    assert_redirected_to @scoreboard
  end
  
  test 'user successfully makes a scoreboard public' do 
    put unprivate_path(:scoreboard_id => @scoreboard.id), scoreboard: {privatization: "false"}
    @scoreboard.reload
    assert_equal false, @scoreboard.privatization
    assert_equal "The scoreboard #{@scoreboard.name_of_scoreboard} is now public", flash[:notice]
    assert_redirected_to @scoreboard
  end

end