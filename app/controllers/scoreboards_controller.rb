class ScoreboardsController < ApplicationController
 
 before_action :logged_in_user, only: [:new, :create, :show, :index]
 before_action :correct_user, only: [:destroy, :edit, :update]

 
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
  @pictureable = @scoreboard
  @picture =  @pictureable.picture || @pictureable.build_picture
  @status =  @scoreboard.status || @scoreboard.build_status
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
    @scoreboard = Scoreboard.find_by_id(params[:id])
    @scoreboard.teams.delete_all
    flash[:success] = "All teams have been deleted. We hope you're happy with your decision."
    redirect_to scoreboard_teams_path(@scoreboard)
 end
 
 def deleteschedules
    @scoreboard = Scoreboard.find_by_id(params[:id])
    @scoreboard.schedules.delete_all
    flash[:success] = "The Schedules has been reset to default settings."
    redirect_to scoreboard_path(@scoreboard)
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
  

end
    
