require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup 
    @user = users(:divjot)
    @topic = topics(:topic_a)
    
    @comment = @topic.comments.build(:body => "whatever", :topic_id => @topic.id, :user_id => @user.id)
  end
  
  test "comment valid" do 
    assert @comment.valid?
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
