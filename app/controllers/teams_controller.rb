class TeamsController < ApplicationController
    
   def create
     @scoreboard = Scoreboard.find(params[:scoreboard_id])
     @team = @scoreboard.teams.build(team_params)
     if @team.save
        respond_to do |format|
         format.html {redirect_to scoreboard_url(@schedule.scoreboard_id)}
         format.js  #this allows the controller to respond to the ajax request that was made by the form.
        end
     else
      respond_to do |format|
         format.html { render action: "new" }
         format.js
      end
     end
   end
     
   # Edit
   def edit
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @team = @scoreboard.teams.find(params[:id])
    respond_to do |format|
     format.html {redirect_to scoreboard_url(@schedule.scoreboard_id)}
     format.js
     end
   end
   
   # Update
   def update
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @team = @scoreboard.teams.find(params[:id])
    if @team.update_attributes(team_params)
     respond_to do |format|
         format.html {redirect_to scoreboard_url(@schedule.scoreboard_id)}
         format.js
     end
    else
      respond_to do |format|
         format.html {redirect_to scoreboard_url(@schedule.scoreboard_id)}
         format.js { render action: "update_error" }
     end
    end
   end
   
   #Delete
   
   def destroy
     @team = Team.find(params[:id])
     @team.destroy
       respond_to do |format|
         format.html {redirect_to scoreboard_url(@schedule.scoreboard_id)}
         format.js
       end
   end
   
   private 
 
   def team_params
     params.require(:team).permit(:name, :win, :loss, :tie)
   end
   

   
end
