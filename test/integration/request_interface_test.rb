require 'test_helper'

class RequestInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:divjot)
    @scoreboard = scoreboards(:scoreboard_a)
    @scoreboard_b = scoreboards(:scoreboard_b)
  end
  
  
  #--------------------------------Test for sending a request.--------------------------------------------
  
  #array @user.sent_requests increases by 1
  test "user sends a request to a scoreboard and @user.sent_requests array increases by 1" do
    log_in_as(@user)
    assert_difference('@user.sent_requests.count', 1) do 
      post request_to_join_path(:scoreboard_id => @scoreboard.id, approved: "false")
      assert_redirected_to @scoreboard
      assert_equal "Request sent", flash[:success]
    end
  end
  
  #array @scoreboard.requested_by by increases by 1
  test "user sends a request to a scoreboard and @scoreboard.requested_by array increases by 1" do
    log_in_as(@user)
    assert_difference('@scoreboard.requested_by.count', 1) do 
      post request_to_join_path(:scoreboard_id => @scoreboard.id, approved: "false")
      assert_redirected_to @scoreboard
      assert_equal "Request sent", flash[:success]
    end
  end
  
  #array @scoreboard.pending_requests would increase by 1
  test "user sends a request to a scoreboard and @scoreboard.pending_requests array increases by 1" do 
    log_in_as(@user)
    assert_difference('@scoreboard.pending_requests.count', 1) do 
      post request_to_join_path(:scoreboard_id => @scoreboard.id, approved: "false")
      assert_redirected_to @scoreboard
      assert_equal "Request sent", flash[:success]
    end
  end
  
  #-----Test for accepting a request, making sure the user becomes a follower and automatically deleting.--------------------------------------------
  
  # user was automatically made a follower, therefore, @scoreboard_b.favourited_by array increases by 1 
  # NOTE: UNIQUENESS VALIDATION ON FAVOURITES, divjot has already favourited scoreboard_a in the favourites table
  test "user accepts a request made to a scoreboard and @scoreboard_b.favourited_by array increases by 1" do
    log_in_as(@user)
    assert_difference('@scoreboard_b.favourited_by.count', 1) do 
      put request_to_join_accept_path(:scoreboard_id => @scoreboard_b.id, :user_id => @user.id),
      request: { approved: "true" }
      assert_redirected_to @scoreboard_b
    end
  end
  
  # the request is deleted after it is requested, @scoreboard.requested_by decreases by 1
  test "user accepts a request made to a scoreboard and @scoreboard.requested_by array decreased by 1" do
    log_in_as(@user)
    assert_difference('@scoreboard.requested_by.count', -1) do 
      put request_to_join_accept_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id),
      request: { approved: "true" }
      assert_redirected_to @scoreboard
    end
  end
  
  # the request is deleted after it is requested, @scoreboard.requests decreases by 1
  test "user accepts a request made to a scoreboard and @scoreboard.requests array decreased by 1" do
    log_in_as(@user)
    assert_difference('@scoreboard.requests.count', -1) do 
      put request_to_join_accept_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id),
      request: { approved: "true" }
      assert_redirected_to @scoreboard
    end
  end
  
  
   #-------------------------Test for deleting a request.-------------------------------------------------
  
  test "user deleted a request made to a scoreboard and @scoreboard.requests array decreases by 1" do
    log_in_as(@user)
    assert_difference('@scoreboard.requests.count', -1) do 
      delete request_to_join_delete_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id, approved: "false")
      assert_redirected_to @scoreboard
    end
  end
  
  
   test "user deleted a request made to a scoreboard and @scoreboard.requested_by array decreases by 1" do
    log_in_as(@user)
    assert_difference('@scoreboard.requested_by.count', -1) do 
      delete request_to_join_delete_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id, approved: "false")
      assert_redirected_to @scoreboard
    end
  end
  
   test "user deleted a request made to a scoreboard and @scoreboard.pending_requests array decreases by 1" do
    log_in_as(@user)
    assert_difference('@scoreboard.pending_requests.count', -1) do 
      delete request_to_join_delete_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id, approved: "false")
      assert_redirected_to @scoreboard
    end
  end 
  
  test "user deleted a request made to a scoreboard and @user.sent_requests array should decrease by 1" do 
    log_in_as(@user)
    assert_difference('@user.sent_requests.count', -1) do
      delete request_to_join_delete_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id, approved: "false")
      assert_redirected_to @scoreboard
    end
  end
  

#----------------------------Must be logged_in_user for CREATE/ACCEPT/DELETE request-------------------------------------
  test "reditect user if not logged when creating" do 
    assert_no_difference '@user.sent_requests.count' do 
      post request_to_join_path(:scoreboard_id => @scoreboard.id, approved: "false")
      assert_template 'static_pages/home'
      assert_equal "Please sign-in to access this page.", flash[:danger]
    end
  end
  
  test "redirect user if not logged in when accepting" do 
    assert_no_difference '@scoreboard_b.favourited_by.count' do 
      put request_to_join_accept_path(:scoreboard_id => @scoreboard_b.id, :user_id => @user.id),
      request: { approved: "true" }
      assert_template 'static_pages/home'
      assert_equal "Please sign-in to access this page.", flash[:danger]
    end
  end
  
   test "redirect user if request deleted when not logged in" do 
    assert_no_difference '@user.sent_requests.count' do
      delete request_to_join_delete_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id, approved: "false")
      assert_template 'static_pages/home'
      assert_equal "Please sign-in to access this page.", flash[:danger]
    end
  end
  
  
end
