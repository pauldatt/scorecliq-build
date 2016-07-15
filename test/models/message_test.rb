require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  
  def setup 
    @messages = messages(:message)
  end
  
  test "body presence must be true" do 
    @messages.body = " "
    assert_not @messages.valid?
  end
  
  test "body length must be 600" do 
    @messages.body = "a" * 601
    assert_not @messages.valid?
  end
  
end
