class ServiceRequestItem < ApplicationRecord
  has_many_attached :before_service_images
  has_many_attached :after_service_images

  belongs_to :service_request
  belongs_to :option
  has_one :employee_slot, dependent: :destroy

  has_one_time_password column_name: :otp_secret_key, length: 4, interval: 120

  enum status: { order_placed: 0, rejected: 1, employee_assigned: 2, in_progress: 3, completed: 4 }

  validates :service_request_id, presence: true
  validates :option_id, presence: true
  validates :time_slot, presence: true
end
