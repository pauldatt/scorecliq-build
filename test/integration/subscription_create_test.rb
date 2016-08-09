require 'test_helper'

class SubscriptionCreateTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:divjot)
    log_in_as(@user)
  end
  
  test "successfully creating a subscription" do 
    get new_user_subscription_path(@user)
    post user_subscription_path(number: "4242424242424242", exp_month: "1217", cvc: "123")
  end
  
end





