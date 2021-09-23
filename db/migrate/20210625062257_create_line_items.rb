class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.integer :category_id
      t.integer :product_id
      t.timestamps
    end
  end
end
