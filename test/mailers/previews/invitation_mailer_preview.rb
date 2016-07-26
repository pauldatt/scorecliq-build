# Preview all emails at http://localhost:3000/rails/mailers/invitation_mailer
class InvitationMailerPreview < ActionMailer::Preview

# Preview this email at https://scorecliq-dmehton.c9users.io/rails/mailers/invitation_mailer/send_invitation

    def send_invitation 
        user = User.first
        email = user.email
        scoreboard = Scoreboard.first
        InvitationMailer.send_invitation(scoreboard, email)
    end

end
