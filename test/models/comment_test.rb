require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup 
    @user = users(:divjot)
    @scoreboard = scoreboards(:scoreboard_a)
    
    @comment = @scoreboard.comments.new(:body => "whatever", :user_id => @user.id, :scoreboard_id => @scoreboard.id)
  end
  
  test "comment presence must be true" do
    @comment.body = " "
    assert_not @comment.valid?
  end
  
  test "comment length must be less than 140 characters" do
    @comment.body = "a" * 141
    assert_not @comment.valid?
  end
  
end
