require 'test_helper'

class InvitationCreateTest < ActionDispatch::IntegrationTest
  
  def setup 
    ActionMailer::Base.deliveries.clear
    @user = users(:divjot)
    @scoreboard = scoreboards(:scoreboard_a)
    log_in_as(@user)
  end
  
  
  test "valid creation of an invitation email" do
    get new_invitation_path(scoreboard_id: @scoreboard.id)
    post invitations_path, invites: {recipient_email: " ", recipient_email: " "}
  end
  
end
