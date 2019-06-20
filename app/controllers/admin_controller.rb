class AdminController < ApplicationController
  # before_action :authenticate
  
  def index
    @total_orders = Order.count
  end

  # def authenticate
  #   authenticate_or_request_with_http_basic('Administration') do |username, password|
  #       ActiveSupport::SecurityUtils.secure_compare(username, "admin") &&
  #       ActiveSupport::SecurityUtils.secure_compare(password, "password")
  #   end
  # end
  

end 
