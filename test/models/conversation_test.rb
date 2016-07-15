require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  
  def setup 
    @conversation = conversations(:convo_one)
  end
  
  test "subject should be maximum of 80 characters" do 
    @conversation.subject = "a" * 81
    assert_not @conversation.valid?
  end
  
  test "subject should be present" do 
    @conversation.subject = " "
    assert_not @conversation.valid?
  end
  
end
