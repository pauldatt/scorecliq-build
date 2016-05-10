class TeamMembersController < ApplicationController
    
    def new 
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @team = Team.find(params[:team_id])
        @team_members = @team.members
        @followers = @scoreboard.favourited_by.search(params[:search]).paginate(page: params[:page], per_page: 50)
    end
    
    def add
        @user = User.find(params[:id])
        @team = Team.find(params[:team_id])
        @team_member = @team.team_members.build(user_id: @user.id)
        if (@team.members.count < 51)
            if @team_member.save
                respond_to do |format|
                    format.html { redirect_to :back }
                    format.js 
                end
            else
                respond_to do |format|
                    format.html { redirect_to :back }
                    format.js { render action: "add_error" }
                end
            end
        else
            respond_to do |format|
                    format.html { redirect_to :back }
                    format.js { render action: "add_error2" }
            end
        end
    end 
    
    def destroy
       @user = User.find(params[:user_id])
       @team = Team.find(params[:team_id])
       @team.members.delete(@user)
       flash[:success] = "Member Removed"
       redirect_to :back
    end
    
    def assign
        @team = Team.find(params[:team_id])
        @user = User.find(params[:member_id])
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @team_member = TeamMember.where(:team_id => @team.id, :user_id => @user.id).first
        @team_member.update_attributes(:captain => "true")
        flash[:notice] = "Captain Assigned"
        redirect_to scoreboard_team_path(@scoreboard, @team)
    end
    
    def unassign
        @team = Team.find(params[:team_id])
        @user = User.find(params[:member_id])
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @team_member = TeamMember.where(:team_id => @team.id, :user_id => @user.id).last
        @team_member.update_attributes(:captain => "false")
        flash[:notice] = "Captain Removed"
        redirect_to scoreboard_team_path(@scoreboard, @team)
    end
    
    
end
