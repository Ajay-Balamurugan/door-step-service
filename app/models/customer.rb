class Customer < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user

  validates :address, presence: true
  validates :phone_number, presence: true, length: { is: 10, message: "Phone number must have 10" }
end
