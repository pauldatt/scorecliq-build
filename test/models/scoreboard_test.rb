# These are the tests for the validations.
require 'test_helper'

class ScoreboardTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:divjot)
    @scoreboard = @user.scoreboards.build(name_of_scoreboard: "Scoreboard A", name_of_organization: 
                  "Organization A", name_of_activity: "Activity A")
    @status = statuses(:status_a)
                  
  end
    
    test "should be valid" do
      assert @scoreboard.valid?
    end

    
    # Testing the name and length of "name of scoreboards".
    test "name of scoreboard should be present" do
      @scoreboard.name_of_scoreboard = " "
      assert_not @scoreboard.valid?
    end
    
    test "name of scoreboard should be maximum of 50 characters" do
      @scoreboard.name_of_scoreboard = "a" * 51
      assert_not @scoreboard.valid?
    end
    
    #Testing the name and length of "name of organizations".
    test "name of organizations should be present" do
      @scoreboard.name_of_organization = " "
      assert_not @scoreboard.valid?
    end
    
    test "name of the organization should be maximum of 50 characters" do
      @scoreboard.name_of_organization = "a" * 51
      assert_not @scoreboard.valid?
    end
    
    # Testing name and length of the "name of activity"
    test "name of activity should be present" do
      @scoreboard.name_of_activity = " "
      assert_not @scoreboard.valid?
    end
    
    test "name of activity should be at most 50 characters" do
      @scoreboard.name_of_activity = "a" * 51
      assert_not @scoreboard.valid?
    end
    
    
    test "user ID must be present" do
      @scoreboard.user_id = nil
      assert_not @scoreboard.valid?
    end
  
    test "order should be most recent first" do
      assert_equal Scoreboard.first, scoreboards(:most_recent)
    end
    
    test "associated teams should be destroyed if scoreboard is destroyed" do
      @scoreboard.save
      @scoreboard.teams.create!(name: "abc", win: 0, loss: 0, tie: 0)
      assert_difference"Team.count", -1 do
        @scoreboard.destroy
      end
    end
    
    test "associated schedules should be destroyed if scoreboard is destroyed" do
      @scoreboard.save
      @scoreboard.schedules.create!(team1: "abc", team2: "ded", detail: "notimportant", 
                                    match_date: "feb 25th,1993", match_time: "anytime")
      assert_difference"Schedule.count", -1 do
        @scoreboard.destroy
      end
    end
  
end
