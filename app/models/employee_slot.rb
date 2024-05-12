class EmployeeSlot < ApplicationRecord
  belongs_to :user
  belongs_to :service_request_item

  validates :user_id, :service_request_item_id, :time_slot, presence: true

  after_create :send_mail_to_employee

  private

  def send_mail_to_employee
    service_request_item.update(status: 'employee_assigned')
    SlotMailer.with(employee_slot: self).new_slot.deliver_later
  end
end
