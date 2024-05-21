class Service < ApplicationRecord
  acts_as_paranoid

  has_many_attached :images
  has_many :options, dependent: :destroy
  has_many :users

  validates :title, presence: true
  validates :description, presence: true
end
