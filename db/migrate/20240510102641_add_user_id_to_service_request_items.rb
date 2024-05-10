class AddUserIdToServiceRequestItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :service_request_items, :user, foreign_key: true
  end
end
