class Bus < ApplicationRecord
  belongs_to :route   
  
  has_many :bookings, dependent: :destroy    # automatically destroy associated child records when parent record is deleted

  before_create :initialize_available_seats

  before_create :generate_b_id

  validates :bus_no, presence: true

  validates :bus_rn, presence: true, uniqueness: true

  validates :total_seats,presence: true, numericality: true, numericality: {
    greater_than: 0
  }

  validates :available_seats, presence: true, numericality: true, numericality: {
    greater_than_or_equal_to: 0
  }

  validates :window_seats, numericality: {
    less_than_or_equal_to: :total_seats
  }

  private

  def initialize_available_seats
    self.available_seats = total_seats
  end

  def generate_b_id
    last_bus = Bus.order(:id).last

    next_number = 
    if last_bus&.b_id.present?
      last_bus.b_id.delete("BUS").to_i + 1
    else
      1
    end
    self.b_id = "BUS#{next_number.to_s.rjust(6, "0")}"
  end
end