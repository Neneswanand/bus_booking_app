class RemoveBookingIdFromBookings < ActiveRecord::Migration[8.1]
  def change
    remove_column :bookings, :booking_id
  end
end
