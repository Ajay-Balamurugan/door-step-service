class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :option

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
