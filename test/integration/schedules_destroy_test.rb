require 'test_helper'

class SchedulesDestroyTest < ActionDispatch::IntegrationTest
  
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @schedule = schedules(:schedule_a)
  end
  
  test "should destroy the schedule and decrease the count by 1" do
    assert_difference('Schedule.count', -1) do
      xhr :delete, scoreboard_schedule_path(@scoreboard, @schedule)
    end
  end
  
end