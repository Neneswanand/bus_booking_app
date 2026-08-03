class JsonWebToken
 class << self


  def encode(payload)
    payload[:exp] = 24.hours.from_now.to_i    # 24.hours.from_now = From Rails ActiveSupport

    JWT.encode(       # JWT gem
      payload, 
      Rails.application.credentials.secret_key_base,
      "HS256"
    )
  end

  
  def decode(token)
    JWT.decode(       # JWT gem
      token, # Token received from Authorization Header
      Rails.application.credentials.secret_key_base,
      true, # verification flag- verify the token before trusting it
      algorithm: "HS256" 
    )
  end
 end
end


# login - User.authenticate(password) - JsonWebToken.encode(token) - JWT token - postman