module SubscriptionsHelper
    def subscribed?(user)
        current_user.stripe_subscription_id? 
    end
end
