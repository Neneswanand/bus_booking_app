# json.array! @routes, partial: "routes/route", as: :route

json.count @routes.count

json.routes @routes do |route|
  json.partial! "routes/route", route: route
end