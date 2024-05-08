class ServiceRequest < ApplicationRecord
  belongs_to :customer
  has_many :service_request_items, dependent: :destroy
  has_many :options, through: :service_request_items

  after_create :create_service_request_items

  validates :total, presence: true
  validates :customer_id, presence: true

  private

  def create_service_request_items
    customer.cart.cart_items.each do |item|
      ServiceRequestItem.create(service_request: self, option: item.option, time_slot: item.time_slot,
                                status: 'order_placed')
    end
    customer.cart.cart_items.destroy_all
    customer.cart.total = 0
    customer.cart.save
  end
end
