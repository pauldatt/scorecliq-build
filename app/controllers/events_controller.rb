class EventsController < ApplicationController
    before_action :logged_in_user
    before_action :fix_time,   only: [:create, :update]
    before_action :private_entry, only: [:index, :new]
    require 'will_paginate/array'
    
    def index
        @selected = true
        @leagueevent = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @events = @scoreboard.events.order("event_date DESC").paginate(page: params[:page], per_page: 5)
    end
    
    def new 
        @selected = true
        @leagueevent = true 
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @event = Event.new
    end
    
    def create 
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @event = @scoreboard.events.build(event_params)
        if @event.save 
            respond_to do |format|
                format.html {redirect_to scoreboard_events_path(@scoreboard)}
                format.js  
           end
        else
            respond_to do |format|
                format.html {redirect_to new_scoreboard_event_path(@scoreboard)}
                format.js { render action: "event_error" } 
           end
        end
    end
    
    def edit
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @event = Event.find(params[:id])
        @selected = true
        @leagueevent = true
    end
    
    def update
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @event = Event.find(params[:id])
        respond_to do |format|
            if @event.update_attributes(event_params)
                format.html {redirect_to scoreboard_events_path(@scoreboard)}
                format.js 
            else
                format.html {redirect_to edit_scoreboard_event_path(@scoreboard)}
                format.js { render action: "event_error" }
            end
        end
    end
    
    def destroy
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @event = Event.find(params[:id])
        @event.destroy
        respond_to do |format|
            format.html { redirect_to scoreboard_events_path(@scoreboard) }
            format.js
        end     
    end
    
    def fix_time
        if params[:event]["event_time(4i)"].blank? && params[:event]["event_time(5i)"].blank?
            params[:event]['event_time(1i)'] = ""
            params[:event]['event_time(2i)'] = ""
            params[:event]['event_time(3i)'] = ""
            params[:event]['event_time(4i)'] = ""
            params[:event]['event_time(5i)'] = ""
        end
    end
    
    private 
            
        def event_params
            params.require(:event).permit(:event_name, :event_date, :event_time, :location, :notes)
        end
        
        def private_entry
         @scoreboard = Scoreboard.find(params[:scoreboard_id])
         if privacy_restriction?(@scoreboard, current_user)
           redirect_to scoreboard_path(@scoreboard)
           flash[:danger] = "Private League. You must make a request to join before accessing league pages."
         end
        end

end
