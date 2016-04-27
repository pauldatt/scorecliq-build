class EventsController < ApplicationController
    def index
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
    end
end
