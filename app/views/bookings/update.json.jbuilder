json.message "Booking UodatedSuccessfully!!!!!"

json.booking do
  json.partial! "bookings/booking", booking: @booking
end