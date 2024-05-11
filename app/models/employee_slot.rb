class EmployeeSlot < ApplicationRecord
  belongs_to :user
  belongs_to :service_request_item

  validates :user_id, :service_request_item_id, :time_slot, presence: true
end
