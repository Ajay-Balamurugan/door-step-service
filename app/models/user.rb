class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :service_request_items, dependent: :destroy
  has_many :service_requests, dependent: :destroy
  belongs_to :role
  belongs_to :service, optional: true
  has_many :employee_slots, dependent: :destroy

  validates :name, presence: true
  validate :validate_customer_attributes, if: :is_customer?

  def validate_customer_attributes
    errors.add(:address, 'is required') unless address.present?
    return if phone_number.present? && phone_number.length == 10

    errors.add(:phone_number, 'is required and must have 10 digits')
  end

  # def is_customer?
  #   role.name == 'customer'
  # end
end
