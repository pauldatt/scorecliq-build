class InvitationsController < ApplicationController
    
    def new
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @invitation = @scoreboard.sent_invitations.build
    end
    
    def create
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @invitation = @scoreboard.sent_invitations.build(invitation_params)
    if @invitation.save
            @invitation = @invitation.recipient_email.split
            @invitation.each do |e|
                UserMailer.send_invitation_email(@scoreboard, @invitation, @split_email, e).deliver_now
            end
            flash[:success] = "Invitation sent successfully"
            redirect_to new_scoreboard_invitation_path
        else
            render 'new'
    end
    end
end


private


def invitation_params
    params.require(:invitation).permit(:recipient_email)
end




