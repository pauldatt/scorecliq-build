class PrivatesController < ApplicationController
  def privatize
    @scoreboard = Scoreboard.find(params[:id])
    if @scoreboard.update_attributes(:privatization => "1")
        redirect_to @scoreboard
        flash[:notice] = "The scoreboard #{@scoreboard.name_of_scoreboard} is now private"
    else
        redirect_to @scoreboard
        flash[:notice] = "There was an error, please try again."
    end
  end
  
  def unprivatize
    @scoreboard = Scoreboard.find(params[:id])
    if @scoreboard.update_attributes(:privatization => "0")
        redirect_to @scoreboard
        flash[:notice] = "The scoreboard #{@scoreboard.name_of_scoreboard} is now public"
    else
        redirect_to @scoreboard
        flash[:notice] = "There was an error, please try again."
    end
  end

  
  
end