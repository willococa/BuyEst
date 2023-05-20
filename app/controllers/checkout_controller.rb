class CheckoutController < ApplicationController
    def new
        @order = current_order
    end
    def create
      @order = current_order
      checkout_service = CheckoutService.new(@order, current_client)
  
      if checkout_service.checkout
        redirect_to root_path, notice: "Checkout successful!"
      else
        redirect_to root_path, alert: "Failed to checkout."
      end
    end
end
