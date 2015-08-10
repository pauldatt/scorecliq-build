class SearchController < ApplicationController
#   def index
#     if params[:keyword]
#       @users = User.search(params[:keyword])
#         redirect_to @user
#     elsif @scoreboard = Scoreboard.search(params[:keyword])
#         redirect_to @scoreboard
#     end
#   end
# end


def index
  if params[:keyword]
   @scoreboard = Scoreboard.search(params[:keyword])
    scoreboard = Scoreboard.find_by_id(params[:id])
      redirect_to scoreboard
    elsif
      @user = User.search(params[:keyword])
      render :text => "not heloo"
  end
end


end
       
       


