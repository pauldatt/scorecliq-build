require 'test_helper'

class TeamMemberInterfaceTest < ActionDispatch::IntegrationTest
  def setup 
    @scoreboard = scoreboards(:scoreboard_a)
    @team = teams(:team_a)
    @user = users(:divjot)
    @team_member = team_members(:team_member_a)
    log_in_as(@user)
  end
  
  #testing for the teams show page.
  # on the page, only the manager or the owner can edit it.
  test "should get team show page and relevant links must be present" do 
    get scoreboard_team_path(@scoreboard, @team)
    assert_select "a[href=?]", scoreboard_teams_path(@scoreboard) #back to teams button
    assert_select "a[href=?]", new_scoreboard_team_team_member_path(@scoreboard, @team)
    if @team.members.any? 
      assert_template 'teams/_team_member'
    end
  end
  
  # this is adding a member which is done exclusively by manager, owner or admin.
  # you have to test for restricting it on the controller URL for those three guys.
  test "adding a team member and increasing the count of @teams.team_member by 1" do 
    get new_scoreboard_team_team_member_path(@scoreboard, @team)
    assert_difference('@team.members.count', 1 ) do 
      post add_scoreboard_team_team_member_path(@scoreboard, @team, @user)
      assert_redirected_to scoreboard_team_path(@scoreboard, @team)
    end
  end
  
  # same as top
  test "destroying a team member and decreasing the count of @team.team_member by 1" do 
    get new_scoreboard_team_team_member_path(@scoreboard, @team)
    assert_response :success
    assert_difference('@team.members.count', -1) do 
      delete scoreboard_team_team_member_path(@scoreboard, @team, @user)
      assert_equal "Member Removed", flash[:success]
      assert_redirected_to scoreboard_team_path(@scoreboard, @team)
    end
  end
  
  
  test "successfully assigning a captain to team members" do 
    get new_scoreboard_team_team_member_path(@scoreboard, @team)
    put assign_captain_path(:scoreboard_id => @scoreboard.id, :team_id => @team.id, :member_id => @user.id) 
    #n the controller, the member_id is grabbed and the user_id is passed
    assert_equal "Captain Assigned", flash[:success]
    assert_redirected_to scoreboard_team_path(@scoreboard, @team)  
  end
  
  test "successfully unassigning a captain to team members" do 
    get new_scoreboard_team_team_member_path(@scoreboard, @team)
    put unassign_captain_path(:scoreboard_id => @scoreboard.id, :team_id => @team.id, :member_id => @user.id)
    assert_equal "Captain Removed", flash[:danger]
    assert_redirected_to scoreboard_team_path(@scoreboard, @team)
  end
  
  
  
end