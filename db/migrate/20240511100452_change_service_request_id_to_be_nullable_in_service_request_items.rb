class ChangeServiceRequestIdToBeNullableInServiceRequestItems < ActiveRecord::Migration[7.1]
  def change
    change_column_null :service_request_items, :service_request_id, true
  end
end
