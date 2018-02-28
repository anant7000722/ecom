class CartsController < ApplicationController
  def index
  	@product = Product.all
  	@cart = Cart.where(user_id: current_user.id)
  end

  def create
  		
  	 	@cart = Cart.new
  	 	@cart.product_id = session[:product_id]
		@cart.user_id = current_user.id
		@cart.save
		redirect_to carts_path
  end
end
