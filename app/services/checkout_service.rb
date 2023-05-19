class CheckoutService
    def initialize(order, client)
      @order = order
      @client = client
    end
  
    def checkout
      return false unless @order.client == @client
  
      @order.transaction do
        create_sale
        update_order_status
        create_empty_order
  
        return @order.save
      end
    end
  
    private
  
    def create_sale
      @sale = @order.build_sale
      @sale.client = @client
      # Set any other attributes for the sale
      @sale.save
    end
  
    def update_order_status
      @order.status = :completed # Adjust the status based on your requirements
      @order.checked_out_at = Time.now
      @order.checked_out = true
      @order.save
    end
    # Assuming you have a `current_client` method to retrieve the current logged-in client

    def create_empty_order
        # Check if the client already has an unchecked-out order
        existing_order = @client.orders.find_by(checked_out: false)
    
        # If an existing order is found, return it
        return existing_order if existing_order
    
        # If no existing order is found, create a new empty order
        @client.orders.create(checked_out: false)  
    end
end
  