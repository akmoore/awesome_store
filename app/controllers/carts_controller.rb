class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  
  def edit
  end

  def destroy
    if @cart.destroy
      session[:cart_id] = nil
      flash[:notice] = "Your cart was successfully deleted."
      redirect_to shop_path
    else
      flash[:notice] = "Couldn't delete cart"
      redirect_to edit_cart_path #=> could also be edit_cart_url
    end
  end
end
