 class Customer::CartsController<ApplicationController

	def index
        if user_signed_in?                   
		  @carts = current_user.carts.where(status: "pending")
        else
            @session_carts = session[:cart]
            @products = session[:cart] ? session[:cart].keys.map { |id| Product.find(id) }:[]
        end
	end

	def new
		@cart = Cart.new
	end

	def create
	  @product = Product.find(params[:id])
      if user_signed_in?
        
        @cart = current_user.carts.find_or_create_by(status: 'pending')
		@lineitem=Cart.lineItem(@cart,current_user,@product)
        if @lineitem.save
           redirect_to customer_carts_path
        else
           redirect_to customer_products_path
        end
      else
        if session[:cart].is_a?(Hash)
            if session[:cart].include?(@product.id.to_s)
                session[:cart][@product.id.to_s]["quantity"]+=1
                redirect_to customer_carts_path
            else
                session[:cart][@product.id.to_s] = {quantity: 1, price: @product.price}
                redirect_to customer_carts_path
            end
        else
            session[:cart]={}
            session[:cart][@product.id.to_s] = {quantity: 1, price: @product.price}
        end
      end
	end

	def remove_product 
      if user_signed_in?
		@lineitem=LineItem.find(params[:lineitem_id])
		@lineitem.delete
		redirect_to request.referrer
      else
        session[:cart].delete(params[:id])
        redirect_to request.referrer
      end
    end

    def save_quantity
        if user_signed_in?
            @lineitem=LineItem.find(params[:line_item][:id])
            @lineitem.quantity = params[:line_item][:quantity]
            @lineitem.save
            redirect_to request.referrer
        else
            session[:cart][params[:product][:id]]["quantity"] = params[:product][:qty]
            redirect_to request.referrer
        end
    end
end