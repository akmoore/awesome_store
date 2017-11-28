# store cart id in session
# access cart from more than one place

module CurrentCart
    extend ActiveSupport::Concern

    private

    def set_cart
        @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound #=> if an error occurs, the cart doesn't exist...
        @cart = Cart.create #=> create cart
        session[:cart_id] = @cart.id #=> assign the sessions cart_id to the active cart id
    end
end