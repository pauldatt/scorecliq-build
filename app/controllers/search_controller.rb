class SearchController < ApplicationController

before_action :logged_in_user, only: :index

    def index
        @scoreboard_search = Scoreboard.search_by_scoreboard(params[:search]).paginate(:page => params[:page], :per_page => 5)
    end 

end
