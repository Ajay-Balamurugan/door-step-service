class Employee < ApplicationRecord
  belongs_to :user
  has_many :employee_slots

  accepts_nested_attributes_for :user

  validates :skill, presence: true


end
