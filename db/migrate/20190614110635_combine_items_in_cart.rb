class CombineItemsInCart < ActiveRecord::Migration[5.2]
  def change
  end

  def up 
    # replace multiple itmes for a single product in a cart 
    # iterate over all products in cart
    # define sums - extract product_id and quantity for each product
    # if quantity for a product_id > 1, delete these and replace this sum by single line item entry 
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity>1
          cart.line_items.where(product_id: product_id).delete_all
          item = cart.line_utems.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end


    def down
      LineItem.where("quantity>1").each do |line_item|
        line_item.quantity.times do
          LineItem.create(
            cart_id: line_item.cart_id,
            product_id: line_item.product_id,
            quantity: 1
          )
        end
        line_item.destroy
      end
    end
  end

end
