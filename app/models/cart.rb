class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items
  has_many :options, through: :cart_items
end
