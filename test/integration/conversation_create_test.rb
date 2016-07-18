require 'test_helper'

class ConversationCreateTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:divjot)
    @receiver = users(:sukh)
    @user_convo = user_conversations(:user_convo_one)
  end
  
  test "valid creation of a user conversation" do 
    log_in_as(@user)
    get new_user_conversation_path(@receiver)
    conversation =  post user_conversations_path(@receiver), :user_conversation => {:recipient_id => @receiver.id, :conversation_attributes => {:subject => "subject", 
                                                                                                     :messages_attributes => {"0" => {:body => "body"}}}}
    assert_equal "The conversation was successfully created", flash[:success]
    #redirect_to test is not written
  end
  
  test "invalid creation of a user conversation without subject" do 
    log_in_as(@user)
    get new_user_conversation_path(@receiver)
    post user_conversations_path(@receiver), :user_conversation => {:recipient_id => @receiver.id, :conversation_attributes => {:subject => " ", 
                                                                :messages_attributes => {"0" => {:body => "body"}}}}
    
     assert_equal "Subject cannot be blank", flash[:danger]      
     assert_redirected_to new_user_conversation_path(@receiver)
  end
  
  
  test "invalid creation of a user conversation without message" do 
    log_in_as(@user)
    get new_user_conversation_path(@receiver)
    post user_conversations_path(@receiver), :user_conversation => {:recipient_id => @receiver.id, :conversation_attributes => {:subject => "subject", 
                                                                :messages_attributes => {"0" => {:body => " "}}}}
     
     assert_equal "Message cannot be blank", flash[:danger]     
     assert_redirected_to new_user_conversation_path(@receiver)
  end
  
  test "successfully deleting a conversation" do 
    log_in_as(@user)
    get user_conversations_path(@user)
    put deletion_user_conversation_path(@user, @user_convo), :user_conversation => {:deleted => "true"}
    assert_redirected_to user_conversations_path(@user)
    assert_equal "The conversation was successfully deleted.", flash[:success]
  end
end


