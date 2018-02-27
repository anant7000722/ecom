class NotificationMailer < ApplicationMailer
	  default from: "from@example.com"
    
    def notification_send(user , product)
        @product = product
        @user = user
            
            mail(to: @user.email, subject: 'Your product is available on our site')
            Notification.where("user_id = ? AND product_id = ?" , @user.id , @product.id).destroy_all
    end
end
