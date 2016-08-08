class CardsController < ApplicationController
    before_action :logged_in_user
    
    def update
        customer = Stripe::Customer.retrieve(current_user.stripe_id)
        subscription = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
        subscription.source = params[:stripeToken]
        subscription.save
    
        current_user.update(
          card_last4: params[:card_last4],
          card_exp_month: params[:card_exp_month],
          card_exp_year: params[:card_exp_year],
        )
    
        redirect_to user_subscription_path(current_user)
        flash[:success] = "CARD UPDATED"
    end
    
    
end
