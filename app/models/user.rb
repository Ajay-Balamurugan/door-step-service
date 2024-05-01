class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, employee: 1, admin: 2 }

  has_one :customer, dependent: :destroy
  has_one :employee, dependent: :destroy
  has_one :admin, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :customer
end
