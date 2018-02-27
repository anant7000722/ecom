class User < ApplicationRecord
	has_many :reviews, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    after_create :send_mail

    def send_mail
    	UserMailer.signup_confirmation(self).deliver_now
    end

end
