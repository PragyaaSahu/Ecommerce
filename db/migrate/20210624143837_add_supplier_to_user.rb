class AddSupplierToUser < ActiveRecord::Migration[6.1]
  def change
  	add_column :users, :supplier, :boolean
  end
end
