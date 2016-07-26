require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  
  def setup 
    ActionMailer::Base.deliveries.clear
    @user = users(:divjot)
    @scoreboard = scoreboards(:scoreboard_a)
    @invitation_email = Invitation.new(recipient_name: "name", recipient_email: "name@mail.ca")
  end
  
  test "assert invitation valid" do 
    assert @invitation_email.valid?
  end
  
  test "valid receipient email must be present" do 
    @invitation_email.recipient_email = " "
    assert_not @invitation_email.valid?
  end
  
  test "invitation email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @invitation_email.recipient_email = valid_address
      assert @invitation_email.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "invitation email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com fooboar@xample..com]
    invalid_addresses.each do |invalid_address|
      @invitation_email.recipient_email = invalid_address
      assert_not @invitation_email.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  
end
