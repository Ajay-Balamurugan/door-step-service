class ServiceRequestItem < ApplicationRecord
  belongs_to :service_request
  belongs_to :option

  has_one_time_password column_name: :otp_secret_key, length: 4

  enum status: { order_placed: 0, accepted: 1, rejected: 2, employee_assigned: 3, in_progress: 4, completed: 5 }

  validates :service_request_id, presence: true
  validates :option_id, presence: true
  validates :time_slot, presence: true
end
