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
    
    test "associated comments should be destroyed if scoreboard is destroyed" do 
      @scoreboard.save
      @scoreboard.comments.create!(body: "abc", reply: "def")
      assert_difference"Comment.count", -1 do 
        @scoreboard.destroy
      end
    end
    
    test "associated favourites should be destroyed" do 
      @scoreboard.save
      @scoreboard.favourites.create!(user_id: 1)
      assert_difference"Favourite.count", -1 do 
        @scoreboard.destroy
      end
    end
    
    test "associated picture must be destroyed" do 
      @scoreboard.save
      @scoreboard.build_picture(picture: "abc.jpg", pictureable_type: "scoreboard")
      assert_difference"Picture.count", -1 do 
        @scoreboard.destroy
      end
    end
    
    #status is already built when you save a scoreboard.
    test "associated status must be destroyed" do 
      @scoreboard.save
      assert_difference"Status.count", -1 do 
        @scoreboard.destroy
      end
    end
    
    test "associated events must be destroyed" do 
      @scoreboard.save
      @scoreboard.events.create!(event_name: "abc", event_date: "2016-04-15", event_time: "2016-04-14 22:39:02", notes: "notes", location: "location")
      assert_difference"Event.count", -1 do 
        @scoreboard.destroy
      end
    end
    
    test "associated requests must be destroyed" do 
      @scoreboard.save
      @scoreboard.requests.create!(user_id: 1)
      assert_difference"Request.count", -1 do 
        @scoreboard.destroy
      end
    end
    
    test "associated managers must be destroyed" do 
      @scoreboard.save
      @scoreboard.managers.create!(user_id: 1)
      assert_difference"Manager.count", -1 do 
        @scoreboard.destroy
      end
    end
    
    test "associated categories must be destroyed" do 
      @scoreboard.save
      @scoreboard.categories.create!(name: "name")
      assert_difference"Category.count", -1 do 
        @scoreboard.destroy
      end
    end
    
    test "associated topics must be destroyed" do 
      @scoreboard.save
      @scoreboard.topics.create!(subject: "subject")
      assert_difference"Topic.count", -1 do 
        @scoreboard.destroy
      end
    end
  
end
