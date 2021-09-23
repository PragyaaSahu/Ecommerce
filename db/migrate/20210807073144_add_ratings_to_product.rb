class AddRatingsToProduct < ActiveRecord::Migration[6.1]
  def change
  	add_column :products, :ratings, :integer
  end
end
