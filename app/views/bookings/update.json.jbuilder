json.message "Booking Updated Successfully!!!!!"

json.booking do
  json.partial! "bookings/booking", booking: @booking
end