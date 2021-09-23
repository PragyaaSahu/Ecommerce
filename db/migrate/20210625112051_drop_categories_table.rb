class DropCategoriesTable < ActiveRecord::Migration[6.1]
    def up
     drop_table :categories
    end

    def down
     raise ActiveRecord::IrreversibleMigration
    end
end
