 class Customer::OrdersController<ApplicationController
  before_action :authenticate_user!
  before_action :authorize_customer 
	before_action :get_cart, only: [:new]
	Stripe.api_key = "sk_test_51JAxb5SCyiDBRZbt4lKJl31cRILleGhNNcIXQ3vXqPzh4LBhNsZ8NV5f1PFnkrWrNoxA3fIenUHkN5v7AWqMyhCf00pJkH9YEK"

    def index
      @orders = current_user.orders
    end

    def new
       @order = Order.new
       @sum=params[:total]
    end

    def create

    	@cart = Cart.find(params[:order][:cart_id])
    	@lineitems = @cart.line_items.all
    	@order = Order.new(order_params)
    	@order.user_id = current_user.id
    	if @order.save
        session = Order.session(@cart,@lineitems,@order,request.base_url)
    		redirect_to session.url, status:303
    	else 
            render :new
      end
    end

	  def show
        @order = Order.find(params[:id])
        @cart = @order.cart
	  end
  
	  def payment_successful
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])        
        @cart = Cart.find(@session.metadata.cart_id).update(status: 'ordered')
        @order = Order.find(@session.metadata.order_id)
        @order.update!(status: params[:action], transaction_id: @session.payment_intent)
        OrderMailer.with(order: @order).new_order_email.deliver_now

        redirect_to customer_orders_path
   	end

	  private

    def get_cart
    	  @cart = Cart.find(params[:cart_id])
    end

	  def order_params
  	    params.require(:order).permit(:name, :email, :phone, :address, :total, :user_id, :cart_id)
    end

    def authorize_customer
        redirect_to root_path unless current_user.has_role?(:customer)
    end