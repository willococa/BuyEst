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
        @client.save
        @order.save
    end
end

  private

  def create_sale
    @sale = @order.build_sale
    @sale.total = @order.total_price
    @sale.payment_method = 'Basic'
    @sale.client = @client
    # Set any other attributes for the sale
    @sale.save
  end

  def update_order_status
    @order.status = :completed # Adjust the status based on your requirements
    @order.checked_out_at = Time.now
    @order.checked_out = true
    @client.orders << @order
  end
  # Assuming you have a `current_client` method to retrieve the current logged-in client

  def create_empty_order
    order = Order.new(checked_out: false,  client: @client)
    @client.update(current_order: order)
  end
end
