class Product < ApplicationRecord
    mount_uploader :picture, PictureUploader
    
	belongs_to :category
	belongs_to :user
	has_many :line_items
	has_many :carts, through: :line_items
	has_many :reviews

	validates :picture, presence: true, allow_blank: false
    validates :name, presence: true, allow_blank: false
    validates :price, presence: true, numericality: true

end
