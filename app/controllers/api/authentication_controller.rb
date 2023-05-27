class Api::AuthenticationController < Api::ApplicationController
  skip_before_action :verify_authenticity_token, only: [:login, :register]
  skip_before_action :authenticate_user,  only: [:register, :login]
  def login
    user = Admin.find_by(email: params[:email])

    if user&.valid_password?(params[:password])
      token = JsonWebToken.encode({ uid: user.id })
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def register
    admin = Admin.find_by(email: registration_params[:email])
    admin.uid = SecureRandom.uuid # Generate a UID for the admin

    if admin.save
      token = generate_token(admin) # Generate JWT token
      render json: { token: token }, status: :created
    else
      render json: { error: admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:admin).permit(:email)
  end

  def generate_token(admin)
    payload = { uid: admin.uid }
    secret_key = Rails.application.secret_key_base
    JWT.encode(payload, secret_key, 'HS256')
  end

end
