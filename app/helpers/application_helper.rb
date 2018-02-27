module ApplicationHelper

	def get_status(product)
		if product.status == false
			return 'out of stock'
		else
			return 'available'
		end
	end


    def notification_send(user , prod_id)
        product = Product.find_by(id: prod_id)
        debugger
        user.each do |u|
            user = User.find_by(id: u.user_id)
            NotificationMailer.notification_send(user, product).deliver_now
        end
    end

end
