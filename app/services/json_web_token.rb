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
      token, 
      Rails.application.credentials.secret_key_base,
      true,           #verify flag
      algorithm: "HS256"
    )
  end
 end
end