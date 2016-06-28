class TeamMatchesController < ApplicationController
    before_action :logged_in_user
    before_action :allowed,       only: :new
    require 'will_paginate/array'
    
    def index
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @teams = @scoreboard.teams 
        if (params[:selected_team].present?)
             team_id = params[:selected_team]
             @selection = "List all Matches"
             @games = @scoreboard.team_matches.order("match_date DESC").paginate(page: params[:page], per_page: 10)
             @matches = @games.has_team(team_id)
        else
            @selection = "Search for Matches by Team"
            @matches = @scoreboard.team_matches.order("match_date DESC").paginate(page: params[:page], per_page: 10)
        end
        
    end
    
    def new
       @selected = true
       @scoreboard = Scoreboard.find(params[:scoreboard_id])
       @team_match = TeamMatch.new
       @teams = @scoreboard.teams
    end
    
    def create
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @team_match = @scoreboard.team_matches.build(match_params)
        @team_match.match_time = nil if params[:team_match]["match_time(4i)"].blank? && 
        params[:team_match]["match_time(5i)"].blank?
        if @team_match.save 
            respond_to do |format|
                format.html {redirect_to scoreboard_team_matches_path(@scoreboard)}
                format.js  
           end
        else
            respond_to do |format|
                format.html {redirect_to new_scoreboard_team_match_path(@scoreboard)}
                format.js { render action: "match_error" } 
           end
        end
    end
    
    def edit
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @match = TeamMatch.find(params[:id])
    end
    
    def update
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @match = TeamMatch.find(params[:id])
        respond_to do |format|
          if @match.update_attributes(match_params)
                format.html {redirect_to scoreboard_team_matches_path(@scoreboard)}
                format.js
            else
                format.html {redirect_to scoreboard_team_matches_path(@scoreboard)}
                format.js { render action: "update_error" }
          end
        end
    end
    
    def destroy
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @match = TeamMatch.find(params[:id])
        @match.destroy
        respond_to do |format|
            format.html { redirect_to scoreboard_team_matches_path(@scoreboard) }
            format.js
        end            
    end

    
    private
    
    def match_params
     params.require(:team_match).permit(:team_a_id, :team_b_id, :match_date, :match_time, :location, :score, :scoreboard_id)
    end
    
    def allowed
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        if !(manager_or_owner?(@scoreboard, current_user))
            flash[:danger] = "Only the owner or admin can access this page"
            redirect_to scoreboard_team_matches_path(@scoreboard)
        end
    end
    
        
    
end
