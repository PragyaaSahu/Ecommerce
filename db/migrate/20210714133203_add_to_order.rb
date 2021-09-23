class AddToOrder < ActiveRecord::Migration[6.1]
  def change
  	add_column :orders, :status, :string
  	add_column :orders, :transaction_id, :string
  end
end
