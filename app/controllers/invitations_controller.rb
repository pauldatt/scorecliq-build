class InvitationsController < ApplicationController
    before_action :pick_emails, only: :create
    
    def new
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @invitation= Invitation.new 
        @invitations = []
        2.times do 
            @invitations << Invitation.new
        end
    end
    
    def create
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
     @emails.each do |email|
     UserMailer.send_invitation(@scoreboard, email).deliver_now
     end
     if @errors.empty?
      redirect_to new_invitation_path(scoreboard_id: @scoreboard.id)
      flash[:success] = "Invitations made"
     end 
    end
   
  


private


    def invitation_params(invite_params)
       invite_params.permit(:recipient_email)
    end
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    def pick_emails
       @emails= []
       @errors=[]
       params["invites"].each do |invite|
        if valid_email?(invite[:recipient_email])
            @emails << invite[:recipient_email]
        else if !valid_email?(invite[:recipient_email]) && (invite[:recipient_email] != "")
            @errors << invite[:recipient_email]
        end
        end
       end
    end

    
    def valid_email?(email)
        (email != "")&&(email =~ VALID_EMAIL_REGEX )
    end


    



end
