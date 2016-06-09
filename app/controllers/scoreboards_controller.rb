class ScoreboardsController < ApplicationController
 
 before_action :logged_in_user, only: [:new, :create, :show, :index]
 before_action :correct_user, only: [:destroy, :edit, :update]
 before_action :scoreboard_owner, only: [:admins]
 
 require 'will_paginate/array'

 
 # Create 
 
 def new
   @scoreboard = Scoreboard.new
 end
 
 def create
  @scoreboard = current_user.scoreboards.build(scoreboard_params)
  if @scoreboard.save
   flash[:success] = "Scoreboard created successfully"
   redirect_to scoreboard_path(@scoreboard)
  else
   render 'new'
  end
 end
 

 # Read
 
 def show 
  @selected = true
  @scoreboard = Scoreboard.find_by_id(params[:id])
  @requests = Request.where(:scoreboard_id => @scoreboard.id)
  @pictureable = @scoreboard
  @picture =  @pictureable.picture || @pictureable.build_picture
  @status =  @scoreboard.status || @scoreboard.build_status
  @admins = @scoreboard.managed_by
 end
 
 def followers
  @selected = true
  @scoreboard = Scoreboard.find(params[:id])
  @fags = @scoreboard.favourited_by.search(params[:search]).sort_by{ |a| a.name.downcase }
  @followers = @fags.paginate(page: params[:page], per_page: 50)
 end
 
 def admins
  @selected = true
  @scoreboard = Scoreboard.find(params[:id])
  @admins = @scoreboard.managed_by
  if (@admins.any?)
      @users = @scoreboard.favourited_by.where("users.id NOT IN (?)", @admins.pluck(:id)).search(params[:search]).sort_by{ |a| a.name.downcase }
  else
      @users = @scoreboard.favourited_by.search(params[:search]).sort_by{ |a| a.name.downcase }
  end
  @followers = @users.paginate(page: params[:page], per_page: 50)
 end
 
 
  def index
   @owned_scoreboards = current_user.scoreboards.paginate(:page => params[:owned_page], :per_page => 5)
   @followed_scoreboards= current_user.favourite_scoreboards.paginate(:page => params[:follow_page], :per_page => 5)
  end
    
 #Update
 
 def edit
  @scoreboard = Scoreboard.find(params[:id])
 end
 
 def update
  @scoreboard = Scoreboard.find(params[:id])
  if @scoreboard.update_attributes(scoreboard_params)
    redirect_to @scoreboard
    flash[:success] = "Updated Successfully"
  else
   render 'edit'
  end
 end
 
 #delete
 
 def destroy
  @scoreboard = Scoreboard.find_by_id(params[:id])
  @scoreboard.destroy
  flash[:success] = "Deleted Successfully."
  redirect_to scoreboards_path
 end
 
 def deleteteams
    @scoreboard = Scoreboard.find(params[:id])
    @scoreboard.teams.each do |team|
     team.destroy
    end
    flash[:success] = "All teams have been deleted. We hope you're happy with your decision."
    redirect_to scoreboard_teams_path(@scoreboard)
 end
 
  def deletematches
    @scoreboard = Scoreboard.find(params[:id])
    @scoreboard.team_matches.each do |game|
     game.destroy
    end
    flash[:success]= "All matches have been deleted. We hope you're happy with your decision"
    redirect_to scoreboard_team_matches_path(@scoreboard)
  end
  
  def deleteevents
    @scoreboard = Scoreboard.find(params[:id])
    @scoreboard.events.each do |event|
     event.destroy
    end
    flash[:success]= "All events have been deleted. We hope you're happy with your decision"
    redirect_to scoreboard_events_path(@scoreboard)
  end
 
 def favourite 
  type = params[:type]
  if type == "favourite"
   @scoreboard = Scoreboard.find(params[:id])
   current_user.favourite_scoreboards << @scoreboard
   redirect_to @scoreboard
   flash[:success] = "You followed scoreboard: #{@scoreboard.name_of_scoreboard}"
   
  elsif type == "unfavourite"
   @scoreboard = Scoreboard.find(params[:id])
   current_user.favourite_scoreboards.delete(@scoreboard)
   redirect_to @scoreboard
   flash[:success] = "You unfollowed scoreboard: #{@scoreboard.name_of_scoreboard}"
   
  elsif type == "delfollower"
   @scoreboard = Scoreboard.find(params[:id])
   @user = User.find(params[:user_id])
   @user.favourite_scoreboards.delete(@scoreboard)
   redirect_to followers_scoreboard_path(@scoreboard)
   flash[:success] = "You unfollowed scoreboard: #{@scoreboard.name_of_scoreboard}"
  
   

  elsif type == "unfav-index"
   @scoreboard = Scoreboard.find(params[:id])
   current_user.favourite_scoreboards.delete(@scoreboard)
   redirect_to scoreboards_path
   flash[:success] = "You unfollowed scoreboard: #{@scoreboard.name_of_scoreboard}"
   
  else
   redirect_to @scoreboard
   flash[:notice] = "No action"
  end
 end
 
 


private

 def scoreboard_params
  params.require(:scoreboard).permit(:name_of_scoreboard, :name_of_organization, 
                 :name_of_activity, :cities, :states, :country) # make sure the name of the parameters match with 
                                                                # the exact names written in the scoreboard model.
 end
 
 
  def correct_user
    @user = Scoreboard.find(params[:id]).user
    redirect_to scoreboards_path unless current_user?(@user)
  end
  
  def scoreboard_owner
   @scoreboard = Scoreboard.find(params[:id])
   if @scoreboard.user != current_user
    flash[:danger] = "Access is restricted to owners only."
    redirect_to @scoreboard
   end
  end

end
    
