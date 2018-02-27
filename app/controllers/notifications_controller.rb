class NotificationsController < ApplicationController
  def index
  end

  	def create
	    @product = Product.find(params[:product_id])
	    @notification = @product.notifications.new
	    @notification.user_id = current_user.id
		@notification.save
  end
end 
