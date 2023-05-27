# lib/authentication.rb
class Authentication
  def initialize(headers = {})
    @headers = headers
  end

  def current_user
    return @current_user if defined?(@current_user)

    token = extracted_token
    return unless token
    decoded_token = JsonWebToken.decode(token)
    @current_user = Admin.find_by(uid: decoded_token['uid'])
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end

  private

  def extracted_token
    @headers['Authorization']&.split&.last
  end
end
