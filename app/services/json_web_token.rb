class JsonWebToken
 class << self
  def encode(payload)
    payload[:exp] = 24.hours.from_now.to_i

    JWT.encode(
      payload, 
      Rails.application.credentials.secret_key_base,
      "HS256"
    )
  end

  def decode(token)
    JWT.decode(
      token, # Token received from Authorization Header
      Rails.application.credentials.secret_key_base,
      true, # verify flag- verify the token before trusting it
      algorithm: "HS256"
    )
  end
 end
end