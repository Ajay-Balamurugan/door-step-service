class Service < ApplicationRecord
  has_many_attached :images
  has_many :options, dependent: :destroy
  has_many :users, dependent: :destroy
end
