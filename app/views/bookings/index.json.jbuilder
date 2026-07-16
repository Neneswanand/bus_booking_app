json.total_bookings @bookings.count

json.bookings @bookings do |booking|
  json.partial! "bookings/booking", booking: booking
end