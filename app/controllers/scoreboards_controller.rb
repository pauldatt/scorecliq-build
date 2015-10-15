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
   flash[:scoreboard] = "Scoreboard created successfully"
   redirect_to scoreboard_path(@scoreboard)
  else
   render 'new'
  end
 end
 

 # Read
 def show
  @scoreboard = Scoreboard.find_by_id(params[:id])
  @team = @scoreboard.teams.build
  @comment = @scoreboard.comments.new
 end
 
 
  def index
    if params[:search]
      @scoreboards = Scoreboard.all.search(params[:search])
    else
      @scoreboards = current_user.scoreboards
    end
  end
    
 #Update
 
 def edit
  @scoreboard = Scoreboard.find_by_id(params[:id])
 end
 
 def update
  @scoreboard = Scoreboard.find_by_id(params[:id])
  if @scoreboard.update_attributes(scoreboard_params)
   flash[:success] = "Updated Successfully"
   redirect_to scoreboard_path(@scoreboard)
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
 
 def favourite 
  type = params[:type]
  if type == "favourite"
   @scoreboard = Scoreboard.find(params[:id])
   current_user.favourite_scoreboards << @scoreboard
   redirect_to :back
   flash[:success] = "You followed scoreboard: #{@scoreboard.name_of_scoreboard}"
   
  elsif type == "unfavourite"
   @scoreboard = Scoreboard.find(params[:id])
   current_user.favourite_scoreboards.delete(@scoreboard)
   redirect_to :back
   flash[:success] = "You unfollowed scoreboard: #{@scoreboard.name_of_scoreboard}"
   
  else
   redirect_to :back
   flash[:notice] = "No action"
  end
 end
 


private

  def scoreboard_params
   params.require(:scoreboard).permit(:name_of_scoreboard, :name_of_organization, 
                  :name_of_activity, :starts_at, :ends_at, :cities, :states, :country, :picture, :status ) # make sure the name of the parameters match with 
                                     # the exact names written in the scoreboard model.
  end
  
  # This correct user method works no doubt but I am not sure why?
   def correct_user
     @user = Scoreboard.find(params[:id]).user
     redirect_to scoreboards_path unless current_user?(@user)
   end

end
    
