require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
   def setup 
     @scoreboard = scoreboards(:scoreboard_a)
     @schedule = @scoreboard.schedules.build(team1: "who", team2: "what", detail: "wtf", match_date: Date.parse("20160225"), match_time: "df")
   end
  
  # test for presence must be true
  test "team 1 must be present"do
    @schedule.team1 = " "
    assert_not @schedule.valid?
  end
  
  test "team2 must be present" do
    @schedule.team2 = " "
    assert_not @schedule.valid?
  end
  
  test "match date must be present" do
    @schedule.match_date = " "
    assert_not @schedule.valid?
  end
  
  test "scoreboard_id must be present" do
    @schedule.scoreboard_id = nil
    assert_not @schedule.valid?
  end
  
  # testing the length validation of schedules
  
  test "team1 should be a maximum lenght of 35" do
    @schedule.team1 = "a" * 36
    assert_not @schedule.valid?
  end
  
  test "team2 should be a maximum length of 35" do
    @schedule.team2 = "a" * 36
    assert_not @schedule.valid?
  end
  
  test "detail should be a maximum of 30 characters" do
    @schedule.detail = "a" * 31
    assert_not @schedule.valid?
  end
  
  test "match_time must be a maximum of 8 characters" do
    @schedule.match_time = "a" * 9
  end
  
  
end
