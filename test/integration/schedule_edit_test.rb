require 'test_helper'

class ScheduleEditTest < ActionDispatch::IntegrationTest
  def setup
    @scoreboard = scoreboards(:scoreboard_a)
    @schedule = schedules(:schedule_a)
  end
  
  test "should render the edit template" do
    xhr :get, edit_scoreboard_schedule_path(@scoreboard, @schedule) 
    assert_template 'schedules/edit'
    assert_template 'schedules/_scheduleedit'
    assert_template 'schedules/_schedulesform'
    assert_template 'shared/_error_messages'
  end
  
end
