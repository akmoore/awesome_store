class LineItemsController < ApplicationController
    include CurrentCart
    before_action :set_cart

    def create
        product = Product.find(params[:product_id])
        @line_item = @cart.line_items.build(product: product, price: product.price)
        if @line_item.save
            flash[:notice] = "#{product.name} was added to your cart."
            redirect_to shop_path
        else
            flash[:notice] = "Couldn't add #{product.name} to your cart." #=> use flash[:notice] when you're redirecting to/back; use flash.now[:notice] when using render method.
            redirect_back(fallback_location: shop_path) #=> fallback if there is no back url, it'll just go to the store.
        end
    end
end
