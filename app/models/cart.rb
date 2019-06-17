class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy

    def add_product(product)
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

    def total_price
        # Array::sum method
        line_items.to_a.sum { |item| item.total_price }
    end

    # def set_line_item
    #     line_item = line_items.find_by(product_id: product.id)
    # end

end
