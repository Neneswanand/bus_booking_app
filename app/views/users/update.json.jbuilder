json.message "User Updated Successfully!!!!!"

json.user do |user|
  json.partial! "users/user", user: @user
end

# json.user do |user|
#   json.partial! "users/user", user: @current_user
# end