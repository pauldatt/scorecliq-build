require 'test_helper'

class MessageCreateTest < ActionDispatch::IntegrationTest
  def setup 
      @user = users(:divjot)
      @conversation = conversations(:convo_one)
      @user_convo = user_conversations(:user_convo_one)
      log_in_as(@user)
  end
  
  # THE TESTS GIVE AN ERROR BECAUSE OF HTTP REFERRER. FOR NOT, I COMMENTED THEM OUT.
  
  test "valid creation of a message" do 
      post user_conversation_messages_path(@user, @conversation), message: {body: "abc"}
      assert_redirected_to user_conversation_path(@user, @user_convo)
  end
  
  test "invalid creation of a message" do 
      post user_conversation_messages_path(@user, @conversation), message: {body: " "}
      assert_redirected_to user_conversation_path(@user, @user_convo)
      assert_equal "Message must be between 1-600 characters", flash[:danger]
  end
  
  
  
end
