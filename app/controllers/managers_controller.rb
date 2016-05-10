class ManagersController < ApplicationController 
    
before_action :logged_in_user, only: [:create, :delete]

def create 
    @user = User.find(params[:user_id])
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @manager = @scoreboard.managers.build(:scoreboard_id => @scoreboard.id, :user_id => @user.id)
    if (@scoreboard.managed_by.count < 2)
        if @manager.save 
            redirect_to @scoreboard
            flash[:notice] = "#{@user.name} was assigned as a manager"
        else
            redirect_to @scoreboard
            flash[:notice] = "nothing happened"
        end
    else
        redirect_to @scoreboard
        flash[:notice] = "You cannot assign more than 2 admins for a scoreboard"
    end
end

    def delete 
        @user = User.find(params[:user_id])
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @manager = Manager.where(:scoreboard_id => @scoreboard.id, :user_id => @user.id).last
        @manager.destroy
        flash[:notice] = "#{@user.name} was deleted as a manager"
        redirect_to @scoreboard
    end
        
    
end
