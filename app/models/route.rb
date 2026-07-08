class Route < ApplicationRecord
  validates :source, presence: true

  validates :destination, presence: true

  validates :distance, presence: true, numericality: {
    greater_than: 0
  }

  before_save :downcase_source_and_destination


  private

  def downcase_source_and_destination
      self.source = source.downcase if source.present?
      self.destination = destination.downcase if destination.present?
  end
end
