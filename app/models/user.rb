class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :address, presence: true
  validates :phone_number, presence: true, length: { is: 10, message: 'Phone number must have 10' }
  validates :name, presence: true

  has_many :service_requests, dependent: :destroy # customer association
  belongs_to :role
  belongs_to :service # employee association
  has_many :employee_slots # employee association
end
