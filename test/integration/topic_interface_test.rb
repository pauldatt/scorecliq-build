require 'test_helper'

class TopicInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup 
     @scoreboard = scoreboards(:scoreboard_a)
     @topic = topics(:topic_a)
  end
  
end
