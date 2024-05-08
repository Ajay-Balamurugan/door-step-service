class Option < ApplicationRecord
  acts_as_paranoid

  belongs_to :service
  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  has_many :cart_items
end
