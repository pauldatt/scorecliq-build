class SubscriptionsController < ApplicationController
    before_action :logged_in_user
    
    def show
        @charges = current_user.charges.order("created_at DESC").limit(10)
    end
    
    def new
    
    end
    
    def create 
        customer = if current_user.stripe_id?
                     Stripe::Customer.retrieve(current_user.stripe_id)
                   else
                     Stripe::Customer.create(email: current_user.email)
                   end
    
        subscription = customer.subscriptions.create(
          source: params[:stripeToken],
          plan: "master"
        )
    
        options = {
          stripe_id: customer.id,
          stripe_subscription_id: subscription.id,
        }
    
        # Only update the card on file if we're adding a new one
        options.merge!(
          card_last4: params[:card_last4],
          card_exp_month: params[:card_exp_month],
          card_exp_year: params[:card_exp_year]
        ) if params[:card_last4]
    
        current_user.update(options)
                     
        redirect_to user_subscription_path(current_user)
        flash[:success] = "Subscription Made"
    end
    
    def edit
    end
    
    
    def destroy
        customer = Stripe::Customer.retrieve(current_user.stripe_id)
        customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
        current_user.update(stripe_subscription_id: nil)

        redirect_to user_subscription_path(current_user)
        flash[:success]= "Your subscription has been cancelled."
    end
    
end
