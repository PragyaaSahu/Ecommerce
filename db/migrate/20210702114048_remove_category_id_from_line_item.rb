class RemoveCategoryIdFromLineItem < ActiveRecord::Migration[6.1]
  def change
  	  remove_column :line_items, :category_id, :integer
  end
end
