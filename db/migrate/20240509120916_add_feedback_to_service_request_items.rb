class AddFeedbackToServiceRequestItems < ActiveRecord::Migration[7.1]
  def change
    add_column :service_request_items, :feedback, :text
  end
end
