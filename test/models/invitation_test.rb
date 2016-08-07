require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  
  def setup 
    ActionMailer::Base.deliveries.clear
    @user = users(:divjot)
    @scoreboard = scoreboards(:scoreboard_a)
    @invitation_email = Invitation.new[{recipient_email: " "}]
  end
  
  test "assert invitation valid" do 
    assert @invitation_email.valid?
  end
  
  test "receipient email must be present" do 
    @invitation_email.recipient_email = " "
    assert_not @invitation_email.valid?
  end
  
  test "invitation email validation should accept valid addresses" do
    valid_addresses = %w[user@example...com USER@foo.COM A_US-ER@foo.bar.org
                        first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @invitation_email.recipient_email = valid_address
      assert @invitation_email.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
end




