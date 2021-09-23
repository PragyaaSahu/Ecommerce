class Category < ApplicationRecord
	has_many :products, :dependent => :destroy

	has_many   :subcategories, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
    belongs_to :parent, class_name: "Category", foreign_key: "parent_id", optional: true
    scope :only_categories, -> {where(parent_id: nil)}

    validates :name, presence: true
end