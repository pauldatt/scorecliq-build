require 'test_helper'

class EventInterfaceTest < ActionDispatch::IntegrationTest
   def setup 
     @scoreboard = scoreboards(:scoreboard_a)
     @event = events(:event_a)
     @user = users(:divjot)
     log_in_as(@user)
   end
   
   test "successfully creating an event and the @scoreboard.events array increases by 1" do # this increases the count by 1 in the yaml file
    assert_difference("@scoreboard.events.count", +1) do 
        post scoreboard_events_path(@scoreboard),       event: {event_name: "kjn",
                                                                event_date:  Date.parse("20160225"),
                                                                event_time:  "22:39:02",
                                                                notes:       "abcdef"}
        assert_redirected_to scoreboard_events_path(@scoreboard)                                                     
        assert_equal "event has manifested", flash[:success]                                           
    end
   end
   
   test "UNsuccessfully creating an event and the array count does not change" do 
    assert_no_difference("@scoreboard.events.count") do 
        post scoreboard_events_path(@scoreboard),       event: {event_name: "a" * 31,
                                                                event_date:  Date.parse("20160225"),
                                                                event_time:  "  ",
                                                                notes:       "a" * 141}
        assert_redirected_to scoreboard_events_path(@scoreboard)                                                      
        assert_equal "event are in a struggle", flash[:danger]                                           
    end
   end
   
   test "successfully deleting an event and array decreases by 1" do 
    assert_difference("@scoreboard.events.count", -1) do 
     delete scoreboard_event_path(@scoreboard, @event)
     assert_redirected_to scoreboard_events_path(@scoreboard)
     assert_equal "destroyed successfully",  flash[:success]                                       
    end
   end
 
   
   
end
