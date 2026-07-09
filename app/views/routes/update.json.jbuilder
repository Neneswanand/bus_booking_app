json.message "Route Updated Successfully!!!!!"

json.route do
  json.partial! "routes/route", route: @route
end