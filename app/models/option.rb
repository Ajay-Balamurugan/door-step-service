class Option < ApplicationRecord
  acts_as_paranoid

  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :title, presence: { message: 'Title cannot be blank' }
  validates :description, presence: { message: 'Description cannot be blank' }
  validates :duration, presence: { message: 'Duration cannot be blank' }
  validates :price, presence: { message: 'Price cannot be blank' }

  belongs_to :service

  # made a change here
  has_many :service_request_items
end
