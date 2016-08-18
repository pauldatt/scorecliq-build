class ScoreboardsController < ApplicationController
 
 before_action :logged_in_user, only: [:new, :create, :show, :index]
 before_action :scoreboard_owner, only: [:destroy, :edit, :update, :admins]
 before_action :private_entry, only: [:followers]
 before_action :deny_admin_sub, only: [:admins]

 
 require 'will_paginate/array'

 
 # Create 
 
 def new
   @scoreboard = Scoreboard.new
 end
 
 def create
  if !subscribed?(current_user)&&(current_user.scoreboards.count > 0)
     flash[:danger] = "You must be subscribed to own more than 1 league page."
     redirect_to new_scoreboard_path
  else
    @scoreboard = current_user.scoreboards.build(scoreboard_params)
    if @scoreboard.save
     flash[:success] = "Scoreboard created successfully"
     redirect_to scoreboard_path(@scoreboard)
    else
     render 'new'
    end
  end
 end
 

 # Read
 
 def show 
  @selected = true
  @scoreboard = Scoreboard.find_by_id(params[:id])
  @requests = Request.where(:scoreboard_id => @scoreboard.id)
  @leagueprof = true
  @pictureable = @scoreboard
  @picture =  @pictureable.picture || @pictureable.build_picture
  @status =  @scoreboard.status || @scoreboard.build_status
  @admins = @scoreboard.managed_by
 end
 
 def followers
  @selected = true
  @scoreboard = Scoreboard.find(params[:id])
  @users = @scoreboard.favourited_by.search(params[:search]).sort_by{ |a| a.name.downcase }
  @followers = @users.paginate(page: params[:page], per_page: 50)
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
   if subscribed?(current_user)
      @owned_scoreboards = current_user.scoreboards
   else
      @owned_scoreboards = current_user.scoreboards.order("created_at DESC").limit(1)
   end
   @followed_scoreboards= current_user.favourite_scoreboards
   @mypages = true
  end
    
 #Update
 
 def edit
  @scoreboard = Scoreboard.find(params[:id])
  @selected= true
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
   if @scoreboard.managed_by.include?(current_user)
    @manager = Manager.where(:scoreboard_id => @scoreboard.id, :user_id => current_user.id).last
    @manager.destroy
   end
   redirect_to @scoreboard
   flash[:success] = "You unfollowed scoreboard: #{@scoreboard.name_of_scoreboard}"
   
  elsif type == "delfollower"
   @scoreboard = Scoreboard.find(params[:id])
   @user = User.find(params[:user_id])
   @user.favourite_scoreboards.delete(@scoreboard)
   if @scoreboard.managed_by.include?(@user)
      @manager = Manager.where(:scoreboard_id => @scoreboard.id, :user_id => @user.id).last
      @manager.destroy
   end
   redirect_to followers_scoreboard_path(@scoreboard)
   flash[:success] = "#{@user.name} was removed from #{@scoreboard.name_of_scoreboard}"
  else

   redirect_to @scoreboard
   flash[:danger] = "An error occured. Please try again."
  end
 end
 
 


private

 def scoreboard_params
  params.require(:scoreboard).permit(:name_of_scoreboard, :name_of_organization, 
                 :name_of_activity, :location) # make sure the name of the parameters match with 
                                                                # the exact names written in the scoreboard model.
 end
 
  
  def scoreboard_owner
   @scoreboard = Scoreboard.find(params[:id])
   if @scoreboard.user != current_user
    flash[:danger] = "Access is restricted to owner only."
    redirect_to @scoreboard
   end
  end
  
   def private_entry
     @scoreboard = Scoreboard.find(params[:id])
     if privacy_restriction?(@scoreboard, current_user)
       redirect_to scoreboard_path(@scoreboard)
       flash[:danger] = "Private League. You must make a request to join before accessing league pages."
     end
   end
   
   def deny_admin_sub
    @scoreboard = Scoreboard.find(params[:id])
    if !subscribed?(@scoreboard.user)
       redirect_to scoreboard_path(@scoreboard)
       flash[:danger] = "You must be subscribed in order to assign admins for your league page"
    end
   end

end
    
