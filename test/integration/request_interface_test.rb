require 'test_helper'

class RequestInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:divjot)
    @scoreboard = scoreboards(:scoreboard_a)
    log_in_as(@user)
  end
  
  # Test for sending a request.
  
  test "user sends a request to a scoreboard and @user.sent_requests array increases by 1" do
    assert_difference('@user.sent_requests.count', 1) do 
      post request_to_join_path(:scoreboard_id => @scoreboard.id, approved: "false")
      assert_redirected_to @scoreboard
      assert_equal "Request sent", flash[:notice]
    end
  end
  
  test "user sends a request to a scoreboard and @scoreboard.requested_by array increases by 1" do
    assert_difference('@scoreboard.requested_by.count', 1) do 
      post request_to_join_path(:scoreboard_id => @scoreboard.id, approved: "false")
      assert_redirected_to @scoreboard
      assert_equal "Request sent", flash[:notice]
    end
  end
  
  test "user sends a request to a scoreboard and @scoreboard.pending_requests array increases by 1" do 
    assert_difference('@scoreboard.pending_requests.count', 1) do 
      post request_to_join_path(:scoreboard_id => @scoreboard.id, approved: "false")
      assert_redirected_to @scoreboard
      assert_equal "Request sent", flash[:notice]
    end
  end
  
  # Test for accepting a request
  
  test "user accepts a request made to a scoreboard and @scoreboard.accepted_requests array increases by 1" do
    assert_difference('@scoreboard.accepted_requests.count', 1) do 
      put request_to_join_accept_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id),
      request: { approved: "true" }
      assert_redirected_to @scoreboard
      assert_equal "Request Accepted", flash[:notice]
    end
  end
  
  test "user accepts a request made to a scoreboard and @scoreboard.pending_requests array decreased by 1" do
    assert_difference('@scoreboard.pending_requests.count', -1) do 
      put request_to_join_accept_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id),
      request: { approved: "true" }
      assert_redirected_to @scoreboard
      assert_equal "Request Accepted", flash[:notice]
    end
  end
  
  #the @scoreboard.requested_by and @user.sent_request don't change if the admin has accepted the request.
  
  
  # test for deleting a request
  
   test "user deleted a request made to a scoreboard and @scoreboard.requested_by array decreases by 1" do
    assert_difference('@scoreboard.requested_by.count', -1) do 
      delete request_to_join_delete_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id, approved: "false")
      assert_redirected_to @scoreboard
      assert_equal "Request Declined", flash[:notice]
    end
  end
  
   test "user deleted a request made to a scoreboard and @scoreboard.pending_requests array decreases by 1" do
    assert_difference('@scoreboard.pending_requests.count', -1) do 
      delete request_to_join_delete_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id, approved: "false")
      assert_redirected_to @scoreboard
      assert_equal "Request Declined", flash[:notice]
    end
  end 
  
  test "user deleted a request made to a scoreboard and @user.sent_requests array should decrease by 1" do 
    assert_difference('@user.sent_requests.count', -1) do
      delete request_to_join_delete_path(:scoreboard_id => @scoreboard.id, :user_id => @user.id, approved: "false")
      assert_redirected_to @scoreboard
      assert_equal "Request Declined", flash[:notice]
    end
  end
  
end
