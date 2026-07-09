# json.extract! @user, :id, :name, :email, :role, :age, :phone, :gender

json.user do |user|
  json.partial! "users/user", user: @user
end