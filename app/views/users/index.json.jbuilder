# json.array! users do |users|
#   json.extract! users, :id, :name, :email, :role
# end

json.total_count @users.count

json.users @users do |user|
  json.partial! "users/user", user: user
end