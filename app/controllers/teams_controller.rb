class TeamsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy, :index]
  
   def index 
    @selected = true
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @teams = @scoreboard.teams.sort_by{ |t| t.name.downcase }
    @team = @scoreboard.teams.new 
   end
   
   def show
    @selected = true
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @team = Team.find(params[:id])
   end
   
    
   def create
     @scoreboard = Scoreboard.find(params[:scoreboard_id])
     @team = @scoreboard.teams.build(team_params)
     if (@scoreboard.teams.count < 100) #a scoreboard can have maximum 100 teams 
        if @team.save
           respond_to do |format|
            format.html {redirect_to scoreboard_teams_path(@scoreboard)}
            format.js  #this allows the controller to respond to the ajax request that was made by the form.
           end
        else
         respond_to do |format|
            format.html { redirect_to scoreboard_teams_path(@scoreboard) }
            format.js { render action: "create_error" }
         end
        end
     else
         respond_to do |format|
            format.html { redirect_to scoreboard_teams_path(@scoreboard) }
            format.js { render action: "create_error2" }
         end
     end
   end
     
   # Edit
   def edit
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @team = @scoreboard.teams.find(params[:id])
    respond_to do |format|
     format.html {redirect_to scoreboard_teams_path(@scoreboard)}
     format.js
     end
   end
   
   # Update
   def update
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @team = @scoreboard.teams.find(params[:id])
    if @team.update_attributes(team_params)
     respond_to do |format|
         format.html {redirect_to scoreboard_teams_path(@scoreboard)}
         format.js
     end
    else
      respond_to do |format|
         format.html {redirect_to scoreboard_teams_path(@scoreboard)}
         format.js { render action: "update_error" }
     end
    end
   end
   
   # The update method on the team show page
   def update_name
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @team = Team.find(params[:id])
    if @team.update_attributes(team_params)
        flash[:success] = "Name Updated!"
        redirect_to scoreboard_team_path(@scoreboard, @team)
    else
       flash[:danger] = "Update Failed. Please try again!"
       redirect_to scoreboard_team_path(@scoreboard, @team)
    end
   end
   #Delete
   
   def destroy
     @team = Team.find(params[:id])
     @team.destroy
       respond_to do |format|
         format.html {redirect_to scoreboard_teams_path(@scoreboard)}
         format.js
       end
   end
   
   private 
 
   def team_params
     params.require(:team).permit(:name, :win, :loss, :tie)
   end
   

   
end
