# spec/services/checkout_service_spec.rb
require 'rails_helper'

RSpec.describe CheckoutService, type: :service do
  let(:client) { create(:client) }  
  let(:order) { create(:order, client: client) }
  let(:service) { CheckoutService.new(order, client) }

  describe "#checkout" do
    context "when the order belongs to the client" do
      it "checks out the order and creates a sale" do
        expect(service.checkout).to be_truthy
        expect(order.status).to eq("completed")
        expect(order.checked_out_at).not_to be_nil
        expect(order.checked_out).to be_truthy
        expect(order.sale).to be_present
        expect(order.sale.client).to eq(client)
      end
    end

    context "when the order does not belong to the client" do
      let(:other_client) { create(:client) }
      let(:service) { CheckoutService.new(order, other_client) }

      it "returns false and does not modify the order" do
        expect(service.checkout).to be_falsey
        expect(order.status).not_to eq("completed")
        expect(order.checked_out_at).to be_nil
        expect(order.checked_out).to be_falsey
        expect(order.sale).to be_nil
      end
    end
  end
end
