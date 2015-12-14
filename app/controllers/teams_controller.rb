class TeamsController < ApplicationController

   def create
     @scoreboard = Scoreboard.find(params[:scoreboard_id])
     @team = @scoreboard.teams.build(team_params)
     if @team.save
        respond_to do |format|
         format.html {redirect_to scoreboard_url(@team.scoreboard_id)}
         format.js
        end
        #this allows the controller to respond to the ajax request that was made by the form.
     else
      render 'new'
     end
   end
     
   # Update
   
   def edit
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @team = @scoreboard.teams.find(params[:id])
    respond_to do |format|
         format.html {redirect_to scoreboard_url(@team.scoreboard_id)}
         format.js
     end
   end
   
   def update
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @team = @scoreboard.teams.find(params[:id])
    if @team.update_attributes(team_params)
     respond_to do |format|
         format.html {redirect_to scoreboard_url(@team.scoreboard_id)}
         format.js
     end
    else
     render 'edit'
    end
   end
   
   #Delete
   
   def destroy
     @scoreboard = Scoreboard.find(params[:scoreboard_id])
     @team = Team.find(params[:id]) 
     if @team.destroy
       respond_to do |format|
         format.html {redirect_to scoreboard_url(@scoreboard)} 
         format.js
       end
     end
   end
   
   private 
 
   def team_params
     params.require(:team).permit(:name, :win, :loss, :tie)
   end
   
end
