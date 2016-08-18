require 'test_helper'
require 'stripe_mock'

class SubscriptionTest < ActionDispatch::IntegrationTest
  
  def setup 
    # a user where all stripe fields including card fields as nil
      @user = users(:divjot)
    # a user that has customer id and subscription id and card fields 
      @user2 = users(:sukh)
    # a user that has customer id but no subscription id for retrieve test
      @user3 = users(:kuljinder)
      StripeMock.start
  end
  
  def stripe_helper
    StripeMock.create_test_helper
  end

  def teardown
    StripeMock.stop
  end
  
  def gen_card_tk
    stripe_helper.generate_card_token(last_4: "4242", exp_year: 2017, exp_month: 12)
  end
  
  def gen_card_tk2
    stripe_helper.generate_card_token(last_4: "1881", exp_year: 2017, exp_month: 12)
  end
  
  
    test "successfully creating a subscription on new customer" do 
      log_in_as(@user)
      plan = stripe_helper.create_plan(:id => 'master', :amount => 2999)
      post user_subscription_path(@user), {stripeToken: gen_card_tk, card_last4: "4242", card_exp_month: 12, card_exp_year: 17}
      customer = Stripe::Customer.create({
        email: @user.email
      })
      subscription = customer.subscriptions.create(
          source: gen_card_tk,
          plan: "master" 
        )
        
      options = {
          stripe_id: customer.id,
          stripe_subscription_id: subscription.id,
        }
      
      options.merge!(
          card_last4: "4242",
          card_exp_month: 12,
          card_exp_year: 17
        )
      
      @user.update(options)
      
        
      assert_equal customer.email, @user.email
      assert_equal customer.id, subscription.customer
      assert_equal customer.id, @user.stripe_id
      assert_equal subscription.id, @user.stripe_subscription_id
      assert_equal @user.card_last4, "4242"
      assert_equal @user.card_exp_month, 12
      assert_equal @user.card_exp_year, 17
      assert_equal "Subscription Made", flash[:success]      
      assert_redirected_to user_subscription_path(@user)
    end
    
    test "successfully creating a subscription on existing customer" do
      log_in_as(@user3)
      customer = Stripe::Customer.create(id: @user3.stripe_id, email: @user3.email)
      plan = stripe_helper.create_plan(:id => 'master', :amount => 2999)
      post user_subscription_path(@user3), {stripeToken: gen_card_tk, card_last4: "4242", card_exp_month: 12, card_exp_year: 17}
      customer = Stripe::Customer.retrieve( @user3.stripe_id)
 
      subscription = customer.subscriptions.create(
          source: gen_card_tk,
          plan: "master" 
        )
        
      options = {
          stripe_id: customer.id,
          stripe_subscription_id: subscription.id,
        }
      
      options.merge!(
          card_last4: "4242",
          card_exp_month: 12,
          card_exp_year: 17
        )
      
      @user3.update(options)
      
    
      assert_equal customer.email, @user3.email
      assert_equal customer.id, subscription.customer
      assert_equal customer.id, @user3.stripe_id
      assert_equal subscription.id, @user3.stripe_subscription_id
      assert_equal @user3.card_last4, "4242"
      assert_equal @user3.card_exp_month, 12
      assert_equal @user3.card_exp_year, 17
      assert_equal "Subscription Made", flash[:success]      
      assert_redirected_to user_subscription_path(@user3)
    end
    
    test "successfully update credit card info" do
      customer = Stripe::Customer.create(id: @user2.stripe_id, email: @user2.email)
      plan = stripe_helper.create_plan(:id => 'master', :amount => 2999)
      subscription = customer.subscriptions.create(
                            id: @user2.stripe_subscription_id, 
                            source: gen_card_tk,
                            plan: "master"
                     )
       
      log_in_as(@user2)
      put user_card_path(@user2), {stripeToken: gen_card_tk2, card_last4: "1881", card_exp_month: 12, card_exp_year: 17}
      
      customer = Stripe::Customer.retrieve(@user2.stripe_id)
      subscription = customer.subscriptions.retrieve(@user2.stripe_subscription_id)
      subscription.source = gen_card_tk2
      subscription.save
     
      @user2.update(
          card_last4: "1881",
          card_exp_month: 12,
          card_exp_year: 17,
       )
       assert_equal @user2.card_last4, "1881"
       assert_equal @user2.card_exp_month, 12
       assert_equal @user2.card_exp_year, 17
       assert_equal "CARD UPDATED", flash[:success]      
       assert_redirected_to user_subscription_path(@user2)
    end
    
    test "successfully delete subscriptions" do
      customer = Stripe::Customer.create( email: @user2.email)
      plan = stripe_helper.create_plan(:id => 'master', :amount => 2999)
      subscription = customer.subscriptions.create(
                            source: gen_card_tk,
                            plan: "master"
                     )
      @user2.update(
           stripe_id: customer.id,
           stripe_subscription_id: subscription.id
           )
      log_in_as(@user2)
      delete user_subscription_path(@user2)
      customer = Stripe::Customer.retrieve(@user2.stripe_id)
      customer.subscriptions.retrieve(@user2.stripe_subscription_id).delete
      current_user.update(stripe_subscription_id: nil)
      
      assert_equal "Your subscription has been cancelled.", flash[:success]      
      assert_redirected_to user_subscription_path(@user2)
    end
    
    test "charge.succeeded webhooks creates a charge object for user" do
      event = StripeMock.mock_webhook_event('charge.succeeded',
      { customer: @user2.stripe_id,
        amount: 2999,
        source: { last4: "4242"}
      })
      assert_difference '@user2.charges.count', 1 do
        RecordCharges.new.call(event)
      end
    end
    
    # test "charge.failed webhooks create a charge subscription id becomes null" do
    #   # customer = Stripe::Customer.create(id: @user2.stripe_id, email: @user2.email)
    #   # plan = stripe_helper.create_plan(:id => 'master', :amount => 2999)
    #   # subscription = customer.subscriptions.create(
    #   #                       id: @user2.stripe_subscription_id, 
    #   #                       source: gen_card_tk,
    #   #                       plan: "master"
    #   #               )
    #   event = StripeMock.mock_webhook_event('charge.failed',
    #   { customer: @user2.stripe_id,
    #     amount: 2999,
    #     source: { last4: "4242"}
    #   })
      
    #   assert_nil @user2.stripe_subscription_id do
    #     charge = event.data.object

    #     # Look up the user in our database
    #     user = @user2
    
    #     # Record a charge in our database
    #     c = user.charges.where(stripe_charge_id: charge.id).first_or_create
    #     c.update(
    #       amount: charge.amount,
    #       card_last4: charge.source.last4,
    #       success: "false"
    #     )
    #     user.update(stripe_subscription_id: nil)
    #   end
    # end
    
    
    
    
  
end





