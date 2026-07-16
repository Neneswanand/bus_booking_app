# json.array! @routes, partial: "routes/route", as: :route

json.Total_Routes @routes.count

json.routes @routes do |route|
  json.partial! "routes/route", route: route
end