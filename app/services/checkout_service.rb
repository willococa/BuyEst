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
        send_first_purchase_notification
         @order.save
    end
end

  private

  def create_sale
    @sale = @order.build_sale
    @sale.total = @order.total_price
    @sale.payment_method = 'Basic'
    @sale.client = @client
    @sale.save
  end

  def update_order_status
    @order.status = :completed
    @order.checked_out_at = Time.now
    @order.checked_out = true
    @client.orders << @order
  end
  def create_empty_order
    order = Order.new(checked_out: false,  client: @client)
    @client.update(current_order: order)
  end
  def send_first_purchase_notification
    @order.products.each do |product|
      if !product.has_first_sale?
        product.has_first_sale = true
        product.save
        ProductPurchaseMailer.first_purchase_notification(product).deliver_now
      end
    end
  end
end
