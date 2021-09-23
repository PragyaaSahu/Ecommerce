class Order < ApplicationRecord
	belongs_to :user
	belongs_to :cart

	validates :address, presence: true, allow_blank: false
	validates :phone, numericality: { only_integer: true }
	Stripe.api_key = "sk_test_51JAxb5SCyiDBRZbt4lKJl31cRILleGhNNcIXQ3vXqPzh4LBhNsZ8NV5f1PFnkrWrNoxA3fIenUHkN5v7AWqMyhCf00pJkH9YEK"

	def self.session(cart,lineitems,order,url)
		cart = Cart.find(cart.id)
        @lineitems = cart.line_items.all
					Stripe::Checkout::Session.create({ 
   					payment_method_types: ['card'],	
   					metadata: {cart_id: order[:cart_id],
   							    order_id: order.id},
    							line_items: Order.line_items,
    							mode: 'payment',
    							    success_url: "#{url}/customer/payment_successful?session_id={CHECKOUT_SESSION_ID}",
    							    cancel_url: "#{url}/customer/payment_failed",
  								})			 
    end

    private
	    def self.line_items
        @lineitems.map do |lineitem|
         {
           price_data: {
           currency: 'inr',
           product_data: {
           name: lineitem.product.name,
           },
           unit_amount: (lineitem.price * 100).to_i
           },
           quantity: lineitem.quantity
           }
        end
      end


end
