class AddColumnToOrder < ActiveRecord::Migration[6.1]
  def change
  	add_column :orders, :name, :string
  	add_column :orders, :email, :string
  	add_column :orders, :phone, :integer
  	add_column :orders, :address, :string
  	add_column :orders, :total, :float
  end
end
