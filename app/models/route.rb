class Route < ApplicationRecord
  has_many :buses, dependent: :destroy

  before_save :downcase_and_strip_source_and_destination
  
  validates :source, presence: true

  validates :destination, presence: true

  validates :distance, presence: true, numericality: {
    greater_than: 0
  }

  validate :source_and_destination_cannot_be_same

  private

  def downcase_and_strip_source_and_destination
      self.source = source.strip.downcase if source.present?          # self.source => source attribute of current route object
      self.destination = destination.strip.downcase if destination.present?
  end

  def source_and_destination_cannot_be_same
    return unless source.present? && destination.present?
    if source.strip.downcase == destination.strip.downcase
      errors.add(:destination, "can not be same as source")
    end
  end
end
