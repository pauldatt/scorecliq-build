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
       if not_blank?
        params["invites"].each do |invite|
         if valid_email?(invite[:recipient_email])
            @emails << invite[:recipient_email]
         else if !valid_email?(invite[:recipient_email]) && (invite[:recipient_email] != "")
            @errors << invite[:recipient_email]
         end
         end
        end
       else
          @errors << "You entered no emails. Please go back and enter at least 1 email address"
       end
           
    end
    
    def not_blank? 
        @not_blanks = []
        
        params["invites"].each do |invite|
            if (invite[:recipient_email] != "")
               @not_blanks << invite[:recipient_email]
            end
        end
        
        if @not_blanks.empty?
            return false
        else 
            return true
        end
        
    end
    
    def valid_email?(email)
        (email != "")&&(email =~ VALID_EMAIL_REGEX )
    end


    



end
