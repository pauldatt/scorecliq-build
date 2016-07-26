class InvitationsController < ApplicationController
    before_action :pick_emails, only: :create
    before_action :allowed_user, only: [:new, :create]
    before_action :logged_in_user
    
    def new
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @invitation= Invitation.new 
        @invitations = []
        10.times do 
            @invitations << Invitation.new
        end
    end
    
    def create
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
     @emails.each do |email|
     InvitationMailer.send_invitation(@scoreboard, email).deliver_now
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
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    
    def allowed_user
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        if (manager_or_owner?(@scoreboard, current_user) == false)
            redirect_to scoreboard_path(@scoreboard)
            flash[:danger] = "Access Restricted To Admins only"
        end
    end

    def pick_emails
       @scoreboard = Scoreboard.find(params[:scoreboard_id])
       @emails= []
       @errors=[]
       if not_blank?
        params["invites"].each do |invite|
         if valid_email?(invite[:recipient_email])
            @emails << invite[:recipient_email]
         elsif !valid_email?(invite[:recipient_email]) && (invite[:recipient_email] != "")
            @errors << invite[:recipient_email]
         end
        end
       else
          redirect_to new_invitation_path(scoreboard_id: @scoreboard.id)
          flash[:danger] = "Error: No emails were entered."
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
