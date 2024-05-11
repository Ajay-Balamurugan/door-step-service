class ChangeServiceRequestUserAssociation < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :service_requests, :customers

    remove_column :service_requests, :customer_id, :bigint

    add_column :service_requests, :user_id, :bigint, null: false

    add_foreign_key :service_requests, :users
  end
end
