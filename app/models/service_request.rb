class ServiceRequest < ApplicationRecord
  belongs_to :user
  has_many :service_request_items, dependent: :destroy
  has_many :options, through: :service_request_items

  # after_create :map_service_request_items

  validates :total, presence: true
  validates :user_id, presence: true
end
