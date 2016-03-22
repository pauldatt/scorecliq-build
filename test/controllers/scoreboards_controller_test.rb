require 'test_helper'

class ScoreboardsControllerTest < ActionController::TestCase
    def setup
        @scoreboard = scoreboards(:scoreboard_a)
        @user = users(:divjot) # correct user
        @second_user = users(:sukh) # incorrect user
    end
    
    test "should get new" do
        get :new
        assert_response :success
    end
    
    
    test "should get index" do
        get :index
        assert_response :success
    end
    
    
    test 'should get show' do
        get :show, id: @scoreboard.id
        assert_response :success
    end
    
    # tests for the correct_user before_action filter (destroy, edit, update).
    
    test "should destroy scoreboard only if it is a correct user" do
        log_in_as(@user) #@user is a correct user
        assert is_correct_user?
        assert_difference('Scoreboard.count', -1) do
            delete :destroy, id: @scoreboard.id
        end
    end
    
    test "should get edit scoreboard only if it is a correct_user" do
        log_in_as(@user)
        get :edit, id: @scoreboard.id
        assert_response :success
    end
    
    test "should update scoreboard only if it is a correct_user" do
        log_in_as(@user)
        patch :update, id: @scoreboard, scoreboard: {name_of_scoreboard: "abc", name_of_activity: "def", name_of_organization: "ghi"}
        assert_redirected_to scoreboard_path(@scoreboard)
        assert_not flash.empty?
    end
    
    #should redirect if incorrect user (destroy, update, edit) 
    
    test "should redirect scoreboard if incorrect_user is destroying scoreboard" do
        log_in_as(@second_user) #@second user has no relationship with any socreboard, therefore, not a correct user
        assert_no_difference('Scoreboard.count') do
            delete :destroy, id: @scoreboard.id
        end
        assert flash.empty?
        assert_redirected_to scoreboards_path
    end
    
    test "should redirect scoreboard if incorrect_user is updating scoreboard" do
        log_in_as(@second_user)
        patch :update, id: @scoreboard, scoreboard: {name_of_scoreboard: @scoreboard.name_of_scoreboard, 
                                                    name_of_activity: @scoreboard.name_of_activity, 
                                                    name_of_organization: @scoreboard.name_of_organization }
        assert flash.empty?
        assert_redirected_to scoreboards_path
    end
    
    test "should redirect edit scoreboard action when incorrect_user" do
        log_in_as(@second_user)
        get :edit, id: @scoreboard.id
        assert_redirected_to scoreboards_path
    end
    
    
    # should redirect when not logged in (new, show, index) 
    
    test 'should redirect new when not logged in' do
        get :new
        assert_not flash.empty?
        assert_template 'static_pages/home'
    end
    
    test 'should redirect show when not logged in' do #you are doing this as a non-logged in user
        get :show, id: @scoreboard
        assert_not flash.empty?
        assert_template 'static_pages/home'
    end
    
    test 'should redirect index when not logged in' do
        get :index
        assert_not flash.empty?
        assert_template 'static_pages/home'
    end

    
end



