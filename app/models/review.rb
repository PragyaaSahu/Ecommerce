class Review < ApplicationRecord
	belongs_to :product

	validates :user_name, presence: true, allow_blank: false
    validates :comments, length: { minimum: 4 }
end
