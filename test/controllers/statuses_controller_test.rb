require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
    
    def setup 
        @status = statuses(:status_a)
        @scoreboard = scoreboards(:scoreboard_a)
    end
    
    test "before_create fiter and the default content text" do
        status = Status.new
        status.save
        assert_equal @status.scoreboard_id, @scoreboard.id
        status.content = "Click here to"
        assert_equal(status.send(:content), "Click here to")
    end
    
end
