json.message "Login Successful!!!!!"

json.info "User Info"

json.user do
  json.partial! "users/user", user: @user
end

