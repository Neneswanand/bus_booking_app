class Route < ApplicationRecord
  validates :source, presence: true, 

  validates :destination, presence: true

  validates :distance, presence: true, numericality: {
    greater_than: 0
  }
end
