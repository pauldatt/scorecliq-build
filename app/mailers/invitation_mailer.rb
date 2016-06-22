class InvitationMailer < ApplicationMailer
    
  def send_invitation(scoreboard,email)
    @scoreboard = scoreboard
    mail to: email, subject: "Invitation"
  end
    
end
