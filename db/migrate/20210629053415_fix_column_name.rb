class FixColumnName < ActiveRecord::Migration[6.1]
  def change
  	rename_column :products, :Name, :name
  	rename_column :products,:Description, :description
  	rename_column :products, :Price, :price
  end
end
