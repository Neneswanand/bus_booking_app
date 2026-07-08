json.message "Registration Successful!!!!"

json.user do
  json.partial! "users/user", user: @user
end