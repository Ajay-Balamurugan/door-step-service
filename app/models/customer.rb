class Customer < ApplicationRecord
  belongs_to :user
  has_one :cart

  validates :address, presence: true
  validates :phone_number, presence: true, length: { is: 10, message: "Phone number must have 10" }
end
