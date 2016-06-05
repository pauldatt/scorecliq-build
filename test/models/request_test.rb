require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @user = users(:divjot)
    @request = @scoreboard.requests.build(user_id: @user.id)
  end
  
  test "request is valid" do 
    assert @request.valid?
  end
  
  test "user_id must be present" do 
    @request.user_id = " "
    assert_not @request.valid?
  end
  
  test "scoreboard_id must be present" do 
    @request.scoreboard_id = " "
    assert_not @request.valid?
  end
  
end
