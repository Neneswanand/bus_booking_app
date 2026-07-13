# json.count @bus.count

json.buses @buses do |bus|
  json.partial! "buses/bus", bus: bus
end