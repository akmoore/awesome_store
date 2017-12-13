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
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.add_line_items_from_cart(@cart)

    if @order.save
        Cart.destroy(session[:cart_id]) #=> destroy the cart that the browser is using, so we're pulling it out of the session
        session[:cart_id] = nil
        OderConfirmationMailer.send_order_confirmation(current_user, @order).deliver_now #=> sending order confirmation email
        redirect_to @order, notice: 'Thanks for your order.'
    else
      render :new #=> this will run the new method within the controller, render a new form to save the order.
    end
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :pay_type, :user_id)
  end

end
