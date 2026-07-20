json.message "Login Successful!!!!!"

json.info "User Info"
# json.token @token
json.user do
  json.partial! "users/user", user: @user
end

