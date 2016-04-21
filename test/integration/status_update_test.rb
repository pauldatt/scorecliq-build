require 'test_helper'

class StatusUpdateTest < ActionDispatch::IntegrationTest
  
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @status = statuses(:status_a)
    @user = users(:divjot)
  end
  
  test "successful update of the status" do
    log_in_as(@user)
    content = "abc"
    patch scoreboard_status_path(@scoreboard, @status), status: {content: content}
    @status.reload
    assert_equal content, @status.content
  end
  
  test "unsuccessful update of the status" do
    xhr :patch, scoreboard_status_path(@scoreboard, @status), status: {content: "a" * 300}
    #test for validation
  end
  
end
