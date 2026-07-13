json.message "Bus Updated Successfully!!!!!"

json.bus do
  json.partial! "buses/bus", bus: @bus
end