json.extract! route, :id, :source, :destination, :distance, :created_at, :updated_at
json.url route_url(route, format: :json)
