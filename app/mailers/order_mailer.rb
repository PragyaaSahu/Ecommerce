class OrderMailer < ApplicationMailer
  def new_order_email
    @order = params[:order]

    mail(to: @order.email, subject: "Your order is out for delivery!")
  end

end
