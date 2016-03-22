require 'test_helper'

class ScheduleUpdateTest < ActionDispatch::IntegrationTest
  
  def setup
    @schedule = schedules(:schedule_a)
    @scoreboard = scoreboards(:scoreboard_a)
  end
  
  test "valid updating of the scoreboard" do
    xhr :get, edit_scoreboard_schedule_path(@scoreboard, @schedule) 
    team1 = "lordof"
    team2 = "therings"
    detail = "execution is everything"
    match_time = "whatever"
    match_date = Date.parse("20160225")
    xhr :patch, scoreboard_schedule_path(@scoreboard, @schedule), schedule: {team1: team1,
                                                                             team2: team2,
                                                                             detail: detail,
                                                                             match_time: match_time,
                                                                             match_date: match_date }
                                                          
    @schedule.reload
    assert_equal team1, @schedule.team1
    assert_equal team2, @schedule.team2
    assert_equal detail, @schedule.detail
    assert_equal match_time, @schedule.match_time
    assert_equal match_date, @schedule.match_date
  end
  
  test 'invalid updating of the scoreboard' do
    team1 = "  "
    team2 = "  "
    detail = "execution is everything"
    match_time = "whatever"
    match_date = "  "
    xhr :patch, scoreboard_schedule_path(@scoreboard, @schedule), schedule: {team1: team1,
                                                                             team2: team2,
                                                                             detail: detail,
                                                                             match_time: match_time,
                                                                             match_date: match_date }
    assert_template 'schedules/_schedule_errors'
    assert_template 'schedules/schedule_update_error'
    
  end
  
  
end

