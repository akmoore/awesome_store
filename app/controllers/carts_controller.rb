class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  
  def edit
  end
end
