class Employee < ApplicationRecord
  belongs_to :user
  belongs_to :service
  has_many :employee_slots

  accepts_nested_attributes_for :user
end
