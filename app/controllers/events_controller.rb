class EventsController < ApplicationController
    before_action :logged_in_user
    
    def index
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @events = @scoreboard.events
    end
    
    def new 
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @event = Event.new
    end
    
    def create 
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @event = @scoreboard.events.build(event_params)
        if @event.save
            redirect_to scoreboard_events_path(@scoreboard)
            flash[:success] = "event has manifested"
        else
            redirect_to scoreboard_events_path(@scoreboard)
            flash[:danger] = "event are in a struggle"
        end
    end
    
    def update
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @event = Event.find(params[:id])
        @event.update_attributes(event_params)
        if @event.update
            flash[:success] = "updated successfully"
        else
            flash[:danger] = "did not update successfully"
        end
    end
    
    def destroy
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @event = Event.find(params[:id])
        @event.destroy
        flash[:success] = "destroyed successfully"
        redirect_to scoreboard_events_path(@scoreboard)
    end
    
    private 
            
        def event_params
            params.require(:event).permit(:event_name, :event_date, :event_time, :notes)
        end

end
