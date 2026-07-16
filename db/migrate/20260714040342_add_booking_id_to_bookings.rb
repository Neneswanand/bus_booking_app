class AddBookingIdToBookings < ActiveRecord::Migration[8.1]
  def change
    add_column :bookings, :booking_id, :string
  end
end
