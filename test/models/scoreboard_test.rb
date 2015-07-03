# These are the tests for the validations.
require 'test_helper'

class ScoreboardTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:divjot)
    @scoreboard = @user.scoreboards.build(name_of_scoreboard: "Scoreboard A", name_of_organization: 
                  "Organization A", name_of_activity: "Activity A", content: "Admin message")
                  
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
    
    test "user ID should be present" do
      @scoreboard.user_id = nil
      assert_not @scoreboard.valid?
    end
    
    test "content should be present" do
      @scoreboard.content = " "
      assert_not @scoreboard.valid?
    end
    
    test "content should be a maximum of 50 characters" do
      @scoreboard.content = "a" * 141
      assert_not @scoreboard.valid?
    end
    
    # This test requires having some micropost fixtures. They are defined in fixtures.yml
    test "order should be most recent first" do
      assert_equal Scoreboard.first, scoreboards(:most_recent)
    end
  
end
