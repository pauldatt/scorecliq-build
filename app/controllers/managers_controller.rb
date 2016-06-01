class ManagersController < ApplicationController 
    
before_action :logged_in_user, only: [:create, :delete]

def create 
    @user = User.find(params[:user_id])
    @scoreboard = Scoreboard.find(params[:scoreboard_id])
    @manager = @scoreboard.managers.build(:scoreboard_id => @scoreboard.id, :user_id => @user.id)
    if (@scoreboard.managed_by.count < 2)
        if @manager.save 
            redirect_to admins_scoreboard_path(@scoreboard)
            flash[:success] = "#{@user.name} was assigned as a manager"
        else
            redirect_to @scoreboard
            flash[:success] = "nothing happened"
        end
    else
        redirect_to admins_scoreboard_path(@scoreboard)
        flash[:danger] = "You cannot assign more than 2 admins to a scoreboard"
    end
end

    def delete 
        @user = User.find(params[:user_id])
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @manager = Manager.where(:scoreboard_id => @scoreboard.id, :user_id => @user.id).last
        @manager.destroy
        flash[:success] = "#{@user.name} was deleted as a manager"
        redirect_to admins_scoreboard_path(@scoreboard)
    end
        
    
end
