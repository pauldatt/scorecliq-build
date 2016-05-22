class TeamMembersController < ApplicationController
    before_action :mass_unassign, only: :assign
    before_action :allowed,       only: :new
    require 'will_paginate/array' 
    
    def new 
        @selected = true
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @team = Team.find(params[:team_id])
        @team_members = @team.members
        if (@team_members.any?)
           @fags = @scoreboard.favourited_by.where("users.id NOT IN (?)", @team_members.pluck(:id)).search(params[:search]).sort_by{ |a| a.name.downcase }
        else
           @fags = @scoreboard.favourited_by.search(params[:search]).sort_by{ |a| a.name.downcase }
        end
        @followers = @fags.paginate(page: params[:page], per_page: 50)
    end
    
    def add
        @user = User.find(params[:id])
        @team = Team.find(params[:team_id])
        @team_member = @team.team_members.build(user_id: @user.id)
        if (@team.members.count < 30)
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
        flash[:success] = "Captain Assigned"
        redirect_to scoreboard_team_path(@scoreboard, @team)
    end
    
    def unassign
        @team = Team.find(params[:team_id])
        @user = User.find(params[:member_id])
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @team_member = TeamMember.where(:team_id => @team.id, :user_id => @user.id).first
        @team_member.update_attributes(:captain => "false")
        flash[:success] = "Captain Unassigned"
        redirect_to scoreboard_team_path(@scoreboard, @team)
    end
    
    
    private
    
    def allowed
        @scoreboard = Scoreboard.find(params[:scoreboard_id])
        @team = Team.find(params[:team_id])
        @captain = @team.captains.first
        if !(manager_or_owner?(@scoreboard, current_user)||(current_user == @captain))
            flash[:danger] = "Only the owner, admins or the captain can access the page"
            redirect_to scoreboard_team_path(@scoreboard, @team)
        end
    end
    
    def mass_unassign
        @team = Team.find(params[:team_id])
        @user = User.find(params[:member_id])
        @captains = TeamMember.where(team_id: @team.id, captain: true)
        @captains.each do |c|
            c.captain = false
            c.save
        end
    end
    
end
