# json.extract! route, :id, :source, :destination, :distance, :created_at, :updated_at
# json.url route_url(route, format: :json)
json.id route.id
json.source route.source
json.destination route.destination
json.distance route.distance
json.created_at route.created_at
json.updated_at route.updated_at