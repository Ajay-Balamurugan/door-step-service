class EmployeeSlot < ApplicationRecord
  belongs_to :employee
  belongs_to :service_request_item

  validates :employee_id, :service_request_item_id, :time_slot, presence: true

end
