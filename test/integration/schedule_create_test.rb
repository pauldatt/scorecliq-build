require 'test_helper'

class ScheduleCreateTest < ActionDispatch::IntegrationTest
  
  def setup
    @schedule = schedules(:schedule_a)
    @scoreboard = scoreboards(:scoreboard_a)
    @user = users(:divjot)
  end
  
  test "valid creation of a schedule" do
    log_in_as(@user)
    assert_difference('Schedule.count', 1) do
      xhr :post, scoreboard_schedules_path(@scoreboard), schedule: {team1: "abc",
                                                                    team2: "def",
                                                                    detail: "beamazing",
                                                                    match_time: "sometime",
                                                                    match_date: "Feb. 29,2016"}
    end
  end
  
  test "invalid creation of the scorebaord" do
    log_in_as(@user)
    assert_no_difference("Schedule.count") do
      xhr :post, scoreboard_schedules_path(@scoreboard), schedule: {team1: " ",
                                                                    team2: "  ",
                                                                    detail: "qualitiseverything",
                                                                    match_time: "    ",
                                                                    match_date: "Feb. 29,2016"}
    end
    assert_template 'schedules/_schedule_errors'
  end
  
end
