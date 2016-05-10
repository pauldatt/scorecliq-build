class TeamMatchesController < ApplicationController
    def index
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @team = @scoreboard.teams.build
        @teama = Team.find_by(params[:team_id])
    end
    
end
