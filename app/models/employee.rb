class Employee < ApplicationRecord
  belongs_to :user

  accepts_nested_attributes_for :user

  validates :skill, presence: true


end
