class ProductPurchaseMailer < ApplicationMailer    
  def first_purchase_notification(product)
    @product = product
    @creator = product.admin_creator
    @admins = Admin.admins_except_creator(@creator)

    mail(to: @creator.email, cc: @admins.pluck(:email), subject: 'First Purchase Notification')
  end
end
