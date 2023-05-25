# Preview all emails at http://localhost:3000/rails/mailers/product_purchase_mailer
class ProductPurchaseMailerPreview < ActionMailer::Preview
    def first_purchase_notification
        order = Order.first # Replace with your own order object
        ProductPurchaseMailer.first_purchase_notification(order.products.first)
    end
end
