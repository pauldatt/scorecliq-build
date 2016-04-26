class PrivatesController < ApplicationController
  def privatize
    @scoreboard = Scoreboard.find_by(params[:id])
    if @scoreboard.update_attributes(:private => "1")
        redirect_to @scoreboard
        flash[:notice] = "The scoreboard #{@scoreboard.name_of_scoreboard} is now private"
    else
        redirect_to @scoreboard
        flash[:notice] = "There was an error, please try again."
    end
  end
  
  def unprivatize
    @scoreboard = Scoreboard.find_by(params[:id])
    if @scoreboard.update_attributes(:private => "0")
        redirect_to @scoreboard
        flash[:notice] = "The scoreboard #{@scoreboard.name_of_scoreboard} is now public"
    else
        redirect_to @scoreboard
        flash[:notice] = "There was an error, please try again."
    end
  end

  
  
end