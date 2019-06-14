module CurrentCart
    private
        def set_cart 

            @cart = Cart.find(session[:cart_id])
            # if cart not found, then create cart => rescue
        rescue ActiveRecord::RecordNotFound
            @cart = Cart.create   
            session[:cart_id] = @cart.id
        end

        def set_visits
            @count = Cart.find(session[:counter])
        end

        def increment_count
            session[:counter] ||= 0
            session[:counter] += 1
        end
end
