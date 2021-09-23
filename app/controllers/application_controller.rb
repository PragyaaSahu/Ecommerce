class ApplicationController < ActionController::Base

    #before_action :authenticate_user!

    def after_sign_in_path_for(resource)
        if session[:cart]
            @cart = resource.carts.find_or_create_by!(status: 'pending')
            session[:cart].each do |key, value|
                if @lineitem = LineItem.where(product_id:key, cart_id: @cart.id).first
                    @lineitem.quantity+=1
                    @lineitem.save
                else
                    @lineitem = LineItem.create(cart_id:@cart.id,price:value["price"],quantity:value["quantity"],product_id:key)
                end
            end
            session.delete(:cart)
        end

        if resource.has_role?(:admin)
            admin_users_url
        elsif resource.has_role?(:supplier)
            supplier_categories_url
        elsif resource.has_role?(:customer)
            customer_products_url
        else
            root_path
        end

    end
end
