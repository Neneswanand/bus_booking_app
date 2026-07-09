json.message "Route Created Successfully!!!!!"

json.route do
  json.partial! "routes/route", route: @route
end