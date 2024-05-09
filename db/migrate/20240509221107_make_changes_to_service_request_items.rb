class MakeChangesToServiceRequestItems < ActiveRecord::Migration[7.1]
  def change
    add_column :service_request_items, :order_placed, :boolean, default: false
  end
end
