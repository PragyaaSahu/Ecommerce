class RemoveColumns < ActiveRecord::Migration[6.1]
  def change
  	remove_column :users, :admin
  	remove_column :users, :supplier
  end
end
