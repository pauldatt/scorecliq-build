require 'test_helper'

class ManagerTest < ActiveSupport::TestCase
  
  def setup 
    @user = users(:divjot)
    @scoreboard = scoreboards(:scoreboard_a)
    @manager = @scoreboard.managers.build(:user_id => @user.id)
  end
  
  
  test "assert manager is valid" do 
    assert @manager.valid?
  end
  
  test "scoreboard_id must be present" do 
    @manager.scoreboard_id = " "
    assert_not @manager.valid?
  end
  
  test "user_id must be present" do 
    @manager.user_id = " "
    assert_not @manager.valid?
  end
  
end
