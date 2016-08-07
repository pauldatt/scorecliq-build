Stripe.api_key = ENV['STRIPE_PRIVATE_KEY'] 
STRIPE_PUBLIC_KEY = ENV['STRIPE_PUBLIC_KEY'] 

class RecordCharges
  def call(event)
    charge = event.data.object

    # Look up the user in our database
    user = User.find_by(stripe_id: charge.customer)

    # Record a charge in our database
    c = user.charges.where(stripe_charge_id: charge.id).first_or_create
    c.update(
      amount: charge.amount,
      card_last4: charge.source.last4,
      success: "true"
    )
  end
end

#another class is needed for charge failed 

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', RecordCharges.new
end