class CheckoutController < ApplicationController
    def create
      @order = current_order
      checkout_service = CheckoutService.new(@order, current_client)
  
      if checkout_service.checkout
        redirect_to order_path(@order), notice: "Checkout successful!"
      else
        redirect_to order_path(@order), alert: "Failed to checkout."
      end
    end
end
