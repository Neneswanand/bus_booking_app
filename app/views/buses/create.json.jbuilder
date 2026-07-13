json.message "Bus Created Successfully!!!!!"

json.bus do
  json.partial! "buses/bus", bus: @bus
end