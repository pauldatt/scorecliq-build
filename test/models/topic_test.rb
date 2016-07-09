require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @topic = @scoreboard.topics.build(subject: "abc")
  end
  
  test "assert topic is valid" do 
    assert @topic.valid?
  end
  
  test "subject must be present" do 
    @topic.subject = " "
    assert_not @topic.valid?
  end
  
  test "subject cannot be longer than 30 characters" do 
    @topic.subject = "a" * 81
    assert_not @topic.valid?
  end
  
end
