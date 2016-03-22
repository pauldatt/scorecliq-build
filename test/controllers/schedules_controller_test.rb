require 'test_helper'

class SchedulesControllerTest < ActionController::TestCase
  
  def setup
    @schedule = schedules(:schedule_a)
  end
  
  test 'before save filter' do
    schedule = Schedule.new
    schedule.match_time = "N/A"
    schedule.detail = "N/A"
    assert_equal(schedule.send(:match_time), "N/A")
    assert_equal(schedule.send(:detail), "N/A")
  end
  
end
