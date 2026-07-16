class Booking < ApplicationRecord
  belongs_to :user          # one-to-one connection

  belongs_to :bus

  before_create :generate_booking_id

  before_create :calculate_total_price

  after_create :update_available_seats

  after_destroy :update_available_seats_after_deletion

  validate :enough_seats_available

  private

  def generate_booking_id
    last_booking = Booking.order(:id).last
 
    if last_booking.nil?
      self.booking_id = "BKG000001"
    else
      number = last_booking.booking_id.delete("BKG").to_i + 1
      self.booking_id = "BKG#{number.to_s.rjust(6, "0")}"
    end
  end

  def calculate_total_price
    self.total_price = bus.price * seats
  end

  def update_available_seats
    bus.update!(
      available_seats: bus.available_seats - seats
    )
  end

  def update_available_seats_after_deletion
    bus.update!(
      available_seats: bus.available_seats + seats
    )
  end

  def enough_seats_available
    if bus.nil? || seats.nil?
      return 
    end

    if seats > bus.available_seats
      errors.add(:seats, "Are Not Available!!!")
    end
  end
end
