# frozen_string_literal: true

class Clients::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(Client)
      if resource.current_order.present? && !resource.current_order.checked_out
        flash[:notice] = "Your current order: #{resource.current_order.attributes}"
      else
        order = Order.new(checked_out: false, client: resource)
        resource.update(current_order: order)
        flash[:notice] = "New order created: #{order.attributes}"
      end
    end
    root_path
  end
end
