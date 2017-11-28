class StorefrontController < ApplicationController
  def index
    if params[:search]
      @products = Product.search_by_name_or_description(params[:search], params[:page])
      if @products.empty?
        flash.now[:notice] = "No results found for #{params[:search]}, showing all products instead."
        @products = Product.all
      end
    elsif params[:category_id]
      @category = Category.find(params[:category_id])
      @products = Product.where(category_id: @category.id).paginate(:page => params[:page])
    else
      # @products = Product.all
      @products = Product.paginate(:page => params[:page], :per_page => 3)
    end
  end

  def about
  end
end
