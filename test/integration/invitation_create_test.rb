require 'test_helper'

class InvitationCreateTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:divjot)
    @scoreboard = scoreboards(:scoreboard_a)
    log_in_as(@user)
  end
  
  
  test "invalid creation of an invitation email (empty emails)" do
    get new_invitation_path(scoreboard_id: @scoreboard.id)
    post invitations_path, scoreboard_id: @scoreboard.id, invites: [{:recipient_email =>" "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, 
    {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "} ]
    assert_equal "Error: No emails were entered.", flash[:danger]
  end
  
  test "invalid creation of an invitation email (invalid email)" do
    get new_invitation_path(scoreboard_id: @scoreboard.id)
    post invitations_path, scoreboard_id: @scoreboard.id, invites: [{:recipient_email =>"swag"}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, 
    {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "} ]
    assert_template 'invitations/create'
  end
  
   test "valid creation of a valid email" do
    get new_invitation_path(scoreboard_id: @scoreboard.id)
    post invitations_path, scoreboard_id: @scoreboard.id, invites: [{:recipient_email =>"div@gmail.com"}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, 
    {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "}, {:recipient_email =>"  "} ]
    assert_equal "Invitations made", flash[:success]
  end
  
  
 
  
end
