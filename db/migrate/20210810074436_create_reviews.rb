class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :ratings
      t.text :comments
      t.timestamps
    end
  end
end
