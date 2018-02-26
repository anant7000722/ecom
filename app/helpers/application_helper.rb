module ApplicationHelper

	def get_status(product)
		if product.status == false
			return 'out of stock'
		else
			return 'available'
		end
	end

end
