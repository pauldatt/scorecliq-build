require 'test_helper'

class TopicInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup 
     @scoreboard = scoreboards(:scoreboard_a)
     @user = users(:divjot)
     @topic = topics(:topic_a)
     log_in_as(@user)
  end
  
  test "successfully creating a topic" do
    assert_difference('@scoreboard.topics.count', 1) do 
      post scoreboard_topics_path(@scoreboard), topic: {subject: "abc",
                                                         user_id: @user.id,
                                                         scoreboard_id: @scoreboard.id
      }
      assert_equal "Topic created successfully.", flash[:success]
    end
  end
  
  test "unsuccessfully creating a topic" do
    assert_difference('@scoreboard.topics.count', 0) do 
      post scoreboard_topics_path(@scoreboard), topic: {subject: " ",
                                                         user_id: " ",
                                                         scoreboard_id: " "
      }
      assert_equal "Error. Please try again.", flash[:danger]
    end
  end
  
  
end
