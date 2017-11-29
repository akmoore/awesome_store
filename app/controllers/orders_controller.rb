class OrdersController < ApplicationController
  include CurrentCart
  before_action :authenticate_user!
  before_action :set_cart, only: [:new, :create]

  def new
    if @cart.line_items.empty?
      redirect_to shop_url, notice: 'Your cart is empty.'
      return #=> this is to end the action right here
    end

    #=> can't create an order if the cart is empty.
    @order = Order.new
    @order.user_id = current_user.id
  end

  def create
  end

  def show
  end

end
