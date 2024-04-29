class CreateCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :option, null: false, foreign_key: true
      t.datetime :time_slot

      t.timestamps
    end
  end
end
