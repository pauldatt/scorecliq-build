class SchedulesController < ApplicationController
   
    def create
     @scoreboard = Scoreboard.find(params[:scoreboard_id])
     @schedule = @scoreboard.schedules.build(schedule_params)
     if @schedule.save
        respond_to do |format|
         format.html {redirect_to scoreboard_url(@schedule.scoreboard_id)}
         format.js
        end
        #this allows the controller to respond to the ajax request that was made by the form.
     else
       render 'new'
     end
    end
    
    def edit
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @schedule = @scoreboard.schedules.find(params[:id])
    respond_to do |format|
         format.html {redirect_to scoreboard_url(@schedule.scoreboard_id)}
         format.js
     end
    end
   
   def update
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @schedule = @scoreboard.schedules.find(params[:id])
    if @schedule.update_attributes(schedule_params)
     respond_to do |format|
         format.html {redirect_to scoreboard_url(@schedule.scoreboard_id)}
         format.js
     end
    else
     render 'edit'
    end
   end
   
   #Delete
   
   def destroy
     @scoreboard = Scoreboard.find(params[:scoreboard_id])
     @schedule = @scoreboard.schedules.find(params[:id])
     @schedule.destroy
      respond_to do |format|
         format.html {redirect_to scoreboard_url(@schedule.scoreboard_id)}
         format.js
     end
   end
   
   
   private
   
   def schedule_params
     params.require(:schedule).permit(:team1, :team2, :detail)
   end
   
end
