class Cart < ApplicationRecord
	belongs_to :user
	has_many :line_items
	has_many :products, through: :line_items
	has_one :order
    
 
	def Cart.lineItem(cart,current_user,product)
		cart = current_user.carts.find_or_create_by(status: 'pending')
		if lineitem = LineItem.where(product_id: product.id, cart_id: cart.id).first
		   lineitem.quantity+=1
		   lineitem.price = product.price
        else
        	lineitem = LineItem.new
        	lineitem.cart = cart
        	lineitem.quantity = 1
        	lineitem.product = product
        	lineitem.price = product.price 
        end
        lineitem
    end
end
