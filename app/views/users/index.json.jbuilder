# json.array! users do |users|
#   json.extract! users, :id, :name, :email, :role
# end

json.total_count @users.count

# json.users @users do |user|
#   json.id user.id
#   json.name user.name
#   json.email user.email
#   json.role user.role
# end

json.users @users do |user|
  json.partial! "users/user", user: user
end