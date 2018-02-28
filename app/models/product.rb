class Product < ApplicationRecord
	acts_as_votable
	belongs_to :category
	has_many :notifications
	has_many :reviews
	has_many :carts
	has_attached_file :image, styles: { medium: "400x600#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
