require 'test_helper'

class EventInterfaceTest < ActionDispatch::IntegrationTest
   def setup 
     @scoreboard = scoreboards(:scoreboard_a)
     @event = events(:event_a)
     @user = users(:divjot)
     log_in_as(@user)
   end
   
   #successfully creating an event and the @scoreboard.events array increases by 1
   test "successfully creating an event" do 
    # assert_difference("@scoreboard.events.count", 1) do 
        post scoreboard_events_path(@scoreboard),       event: {event_name: "kjn",
                                                                event_date:  Date.parse("20160225"),
                                                                event_time:  "22:39:02",
                                                                notes:       "abcdef"}
                                                              
        # assert_equal "event has manifested", flash[:success]                                           
    # end
   end
   
   test "unsuccessfully creating an event" do 
     
   end
   
   test "successfully deleting an event" do 
   end
   
   test "successfully deleting an event and the array decreases by 1" do 
   end
   
   
   
   
end
