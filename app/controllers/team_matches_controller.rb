class TeamMatchesController < ApplicationController
    def index
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @team = @scoreboard.teams.build
    end
end
