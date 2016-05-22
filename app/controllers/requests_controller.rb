class RequestsController < ApplicationController
    
    before_action :logged_in_user, only: [:create, :accept, :delete]
    
    def create #sending a request
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        # we don't need to pass in the user_id param because we are building it with current_user
        @request = current_user.requests.build(scoreboard_id: @scoreboard.id, approved: "false") #we just did a post request so we can fetch these params
        if @request.save
            redirect_to @scoreboard
            flash[:success] = "Request sent"
        else
            redirect_to @scoreboard
            flash[:danger] = "unable to send request"
        end
    end
    
    def accept #accepting a request and automatically making the user a follower
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @user = User.find(params[:user_id])
        @request = Request.where(:scoreboard_id => @scoreboard.id, :user_id => @user.id).first
        if @request.update_attributes(:approved => "true")
            if @user.favourite_scoreboards.include?(@scoreboard) == false
             @scoreboard.favourited_by << @user
            end
            @request.destroy
            respond_to do |format|
                format.html {redirect_to scoreboard_path(@scoreboard)}
                format.js
            end
        else
            respond_to do |format|
                format.html {redirect_to @scoreboard}
                format.js   {render action: "accept_error" }
            end
        end
    end
    
    
    def delete #declining/deleting a request
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @user = User.find(params[:user_id])
        @request = Request.where(:scoreboard_id => @scoreboard.id, :user_id => @user.id).last
        @request.destroy
        respond_to do |format|
            format.html {redirect_to @scoreboard }
            format.js   
        end
    end
        
    
end
