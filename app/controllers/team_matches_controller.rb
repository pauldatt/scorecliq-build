class TeamMatchesController < ApplicationController
    def index
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @matches = @scoreboard.team_matches.order("match_date DESC")
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
        if @team_match.save 
            respond_to do |format|
                format.html {redirect_to new_scoreboard_team_match_path(@scoreboard)}
                format.js  
           end
        else
            respond_to do |format|
                format.html {redirect_to new_scoreboard_team_match_path(@scoreboard)}
                format.js { render action: "match_error" } 
           end
        end
    end
    
    def destroy
    end

    
    private
    
    def match_params
     params.require(:team_match).permit(:team_a_id, :team_b_id, :match_date, :match_time, :location, :score, :scoreboard_id)
    end
    
end
