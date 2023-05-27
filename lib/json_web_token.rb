# lib/json_web_token.rb
class JsonWebToken
  # Encode a payload into a JWT token
  def self.encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  # Decode a JWT token into a payload
  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base).first
  end
end

