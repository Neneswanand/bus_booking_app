json.message "Booking Created Successfully!!!!!"

json.booking do
  json.partial! "bookings/booking", booking: @booking
end