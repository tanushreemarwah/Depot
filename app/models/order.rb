class Order < ApplicationRecord
    has_many :line_items, dependent: :destroy
    enum pay_type: {
        "Cheque" => 0,
        "Credit card" => 1,
        "Purchase order" => 2
    }

    validates :name, :address, :email, presence: true
    # validation to select one of the pay_types
    validates :pay_type, inclusion: pay_types.keys

    def add_line_items_from_cart(cart)
        cart.line_items.each do |item|
            item.cart_id = nil
            line_items << item
        end
    end

    # add validation for routing #, accounting #, etc before placing order

end
