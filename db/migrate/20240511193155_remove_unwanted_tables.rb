class RemoveUnwantedTables < ActiveRecord::Migration[7.1]
  def change
    drop_table :admins, if_exists: true
    drop_table :cart_items, if_exists: true
    drop_table :carts, if_exists: true
    drop_table :customers, if_exists: true
    drop_table :employees, if_exists: true
  end
end
