class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def index
    @product = Product.order(:title)
  end
end
