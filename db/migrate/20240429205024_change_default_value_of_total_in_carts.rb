class ChangeDefaultValueOfTotalInCarts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :carts, :total, 0
  end
end
