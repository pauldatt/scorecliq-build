require 'test_helper'

class EventTest < ActiveSupport::TestCase
  
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @event = @scoreboard.events.build(event_name: "event_name", event_date: Date.parse("20160225"), event_time: "2016-04-14 22:39:02", notes: "Notea",  )
  end
  
  test "should be valid" do 
    assert @event.valid?
  end
  
  test "event name must be present" do 
    @event.event_name = " "
    assert_not @event.valid?
  end
  
  test "event name cannot be more than 30 characters in length" do 
    @event.event_name = "a" * 31
    assert_not @event.valid?
  end
  
  test "event_date must be present" do 
    @event.event_date = " "
    assert_not @event.valid?
  end
  
  test "event_time must be present" do 
    @event.event_time = " "
    assert_not @event.valid?
  end
  
  test "notes cannot be greater than 140 characters" do 
    @event.notes = "a" * 141
    assert_not @event.valid?
  end
  
end
