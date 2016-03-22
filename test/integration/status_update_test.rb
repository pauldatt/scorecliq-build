require 'test_helper'

class StatusUpdateTest < ActionDispatch::IntegrationTest
  
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @status = statuses(:status_a)
  end
  
  test "successful update of the status" do
    xhr :patch, scoreboard_status_path(@scoreboard, @status), status: {content: "abc"}
    @status.reload
    assert_equal "abc", @status.content
  end
  
  test "unsuccessful update of the status" do
    xhr :patch, scoreboard_status_path(@scoreboard, @status), status: {content: "a" * 300}
  end
  
end
