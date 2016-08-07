require 'test_helper'

class CommentsCreateTest < ActionDispatch::IntegrationTest
    
    def setup 
        @topic = topics(:topic_a)
        @user = users(:divjot)
        @scoreboard = scoreboards(:scoreboard_a)
        @comment = comments(:comment_a)
        log_in_as(@user)
    end
    
    test "valid creation of the comment" do 
        assert_difference("@topic.comments.count", 1) do 
            post scoreboard_topic_comments_path(@scoreboard, @topic), comment: {body: "abc",
                                                                                user_id: @user.id}
        end
    end
    
    test "Inavlid creation of the comment" do 
        assert_no_difference("@topic.comments.count", 1) do 
            post scoreboard_topic_comments_path(@scoreboard, @topic), comment: {body: " ",
                                                                                user_id: @user.id}
            assert_equal "Comment cannot be blank and must be less than 600 characters", flash[:danger]                                                                 
        end
    end
    
    test "valid creation of replies" do 
        assert_difference("@topic.comments.count", 1) do 
             post scoreboard_topic_comments_path(@scoreboard, @topic), comment: {body: "abc",
                                                                                 user_id: @user.id,
                                                                                 parent_id: @comment.id}
        end
    end
  
  
end
