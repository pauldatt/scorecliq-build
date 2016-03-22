require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @status = @scoreboard.build_status(content: "thisisastatus")
  end
  
  test "content length must be a maximum of 250 characters" do
    @status.content = "a" * 300
    assert_not @status.valid?
  end
  
  test "scoreboard_id must be present" do
    @status.scoreboard_id = nil
    assert_not @status.valid?
  end
  
end
