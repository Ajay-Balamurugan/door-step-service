class ServiceRequestItem < ApplicationRecord
  has_many_attached :before_service_images
  has_many_attached :after_service_images

  belongs_to :service_request, optional: true
  belongs_to :option
  belongs_to :user
  has_one :employee_slot, dependent: :destroy
  has_one_time_password column_name: :otp_secret_key, length: 4, interval: 120

  enum status: { order_placed: 0, rejected: 1, employee_assigned: 2, in_progress: 3, completed: 4 }

  validates :option_id, presence: true
  validates :time_slot, presence: true
  validate :time_slot_not_in_past, :time_slot_within_range

  private

  def time_slot_not_in_past
    return unless time_slot.past?

    errors.add(:time_slot, "can't be in the past")
  end

  def time_slot_within_range
    return unless time_slot.hour < 8 || time_slot.hour > 20

    errors.add(:time_slot, 'must be between 8 AM and 8 PM')
  end
end
