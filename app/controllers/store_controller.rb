class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart, :set_visits
  
  skip_before_action :authorize
  def index
    @product = Product.order(:title)
    increment_count
    @total_visits = set_visits
  end

  def increment_count
    session[:counter] ||= 0
    session[:counter] += 1
  end

  def set_visits
    @counts = session[:counter]
  end

end
