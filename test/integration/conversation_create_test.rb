require 'test_helper'

class ConversationCreateTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:divjot)
    @receiver = users(:sukh)
    @conversation = conversations(:convo_one)
    @message = messages(:message) #associated with convo_one
  end
  
  test "valid creation of a user conversation subject" do 
    log_in_as(@user)
    
    post user_conversations_path(@receiver), :user_conversation => {:recipient_id => @receiver.id, :conversation_attributes => {:subject => "subject", 
                                                                :messages_attributes => {"0" => {:body => "body"}}}}
                                                      
  end
  
  test "invalid creation of a user conversation subject" do 
    log_in_as(@user)
    
    post user_conversations_path(@receiver), :user_conversation => {:recipient_id => @receiver.id, :conversation_attributes => {:subject => "subject", 
                                                                :messages_attributes => {"0" => {:body => " "}}}}
     
     assert_equal "blank", flash[:danger]                                                 
  end
  
end



