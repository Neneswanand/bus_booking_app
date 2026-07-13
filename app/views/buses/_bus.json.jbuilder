json.id bus.id
json.bus_name bus.bus_name
json.registration_number bus.registration_number
json.bus_type bus.bus_type
json.total_seats bus.total_seats
json.amenities bus.amenities
json.created_at bus.created_at
json.updated_at bus.updated_at

json.route do
  json.id bus.route.id
  json.source bus.route.source
  json.destination bus.route.destination
  json.distance bus.route.distance
end