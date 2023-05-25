require "rails_helper"

RSpec.describe ProductPurchaseMailer, type: :mailer do
  describe '#first_purchase_notification' do
    let(:creator) { create(:admin) }
    let(:product) { create(:product, creator: creator) }
    let(:order_items) { build_list(:order_item, 2, product: product) }
    let(:admins_to_notify) { create_list(:admin, 2) }
    let(:order) { create(:order, order_items: order_items) }
    let(:mail) { ProductPurchaseMailer.first_purchase_notification(product) }

    it 'sends the email to the creator and copies other admins' do
      puts "ADMINS"
      puts admins_to_notify.inspect
      puts "MAIL"
      puts mail.inspect
      expect(mail.subject).to eq('First Purchase Notification')
      expect(mail.to).to eq([creator.email])
      expect(mail.cc).to eq(admins_to_notify.pluck(:email))
      expect(mail.from).to eq(['notifications@example.com'])
      expect(mail.body.encoded).to include("Dear #{creator.name}")
      expect(mail.body.encoded).to include("This is to inform you that the product '#{product.name}' has been purchased by.")
    end

    it 'delivers the email' do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
