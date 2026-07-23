json.total_routes @routes.count

json.routes @routes do |route|
  json.partial! "routes/route", route: route
end

json.total_buses @buses.count

json.buses @buses do |bus|
  json.partial! "buses/bus", bus: bus
end

