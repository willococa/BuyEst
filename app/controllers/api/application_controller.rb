class Api::ApplicationController < ActionController::Base
  before_action :authenticate_user

  private

  def authenticate_user
    @current_user = Authentication.new(request.headers).current_user
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end
end
