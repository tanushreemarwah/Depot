class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy

    def add_product(product)
        # reset visits to page to 0 when adding new product to cart
        # reset_visits
        # find the item currently in cart by its product_id
        current_item = line_items.find_by(product_id: product.id)

        # if current item exists ?
        if current_item
            # increment quantity of this item
            current_item.quantity += 1
        else
            # create new line item
            current_item = line_items.build(product_id: product.id)
        end
        current_item
    end

    def delete_product(product)
        # function to delete product from the cart 
        # get all line.items
        current_item = line_items.find_by(product_id: product.id)

        # there must be at least one line item to delete
        if current_item
                # delete current item
                current_item.delete_all
                # and decrement quantity 
                current_item.quantity -= 1 
        end

    end

    def total_price
        # Array::sum method
        # to_a -> to array
        line_items.to_a.sum { |item| item.total_price }
    end

    # def set_line_item
    #     line_item = line_items.find_by(product_id: product.id)
    # end


    def reset_visits
        @counts = Cart.find(session[:cart_id, :counter])
        session[:counter] = 0
    end


end
