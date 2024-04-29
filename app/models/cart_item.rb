class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :option

  validates :time_slot, presence: true
end
