class Customer < ApplicationRecord
  after_create :create_cart_for_customer

  belongs_to :user
  has_one :cart
  has_many :service_requests

  validates :address, presence: true
  validates :phone_number, presence: true, length: { is: 10, message: 'Phone number must have 10' }

  private

  def create_cart_for_customer
    Cart.create(customer: self)
  end
end
