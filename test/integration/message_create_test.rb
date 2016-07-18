require 'test_helper'

class MessageCreateTest < ActionDispatch::IntegrationTest
  def setup 
      @user = users(:divjot)
      @conversation = conversations(:convo_one)
      log_in_as(@user)
  end
  
  test "valid creation of a message" do 
      request.env["HTTP_REFERER"] = "users/2/conversations/30"
      post user_conversation_messages_path(@user, @conversation), message: {body: "abc"}
      assert_equal "Message Sent Successfully", flash[:success]
  end
  
  test "invalid creation of a message" do 
      request.env["HTTP_REFERER"] = "/posts"
      post user_conversation_messages_path(@user, @conversation), message: {body: " "}
      assert_equal "Message must be 1-600 characters", flash[:success]
  end
  
  
  
end
