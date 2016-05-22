class PrivatesController < ApplicationController
  
  before_action :logged_in_user, only: [:privatize, :unprivatize]
  
  def privatize
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    if @scoreboard.update_attributes(:privatization => "1")
        redirect_to @scoreboard
        flash[:success] = "The scoreboard #{@scoreboard.name_of_scoreboard} is now private"
    else
        redirect_to @scoreboard
        flash[:success] = "There was an error, please try again." #the only reason why this error message would fire 
    end                                                          #because the validations failed but there are not validation 
  end                                                            #hence it should never really fire
  
  def unprivatize
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    if @scoreboard.update_attributes(:privatization => "0")
      if @scoreboard.pending_requests.any?
        @scoreboard.pending_requests.each do |user|
          @scoreboard.favourited_by << user
        end
        if @scoreboard.requests.any?
          @scoreboard.requests.delete_all
        end
      end
        redirect_to @scoreboard
        flash[:success] = "The scoreboard #{@scoreboard.name_of_scoreboard} is now public"
    else
        redirect_to @scoreboard
        flash[:success] = "There was an error, please try again."
    end
  end

end

