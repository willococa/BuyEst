# spec/requests/api/sales_controller_spec.rb
require 'rails_helper'

RSpec.describe "Api::SalesController", type: :request do
  describe "GET /api/most_purchased_products_by_category" do
    let!(:admin) { create(:admin) }
    let!(:category1) { create(:product_category) }
    let!(:category2) { create(:product_category) }
    let!(:product1) { create(:product, creator: admin) }
    let!(:product2) { create(:product, creator: admin) }
    let!(:product3) { create(:product, creator: admin) }

    before do
      product1.product_categories << category1
      product2.product_categories << category1
      product3.product_categories << category2
      create_test_data
    end

    it "returns the most purchased products by category" do
      token = JsonWebToken.encode({ uid: admin.uid }) # Generate a token for the admin
      headers = { 'Authorization' => "Bearer #{token}" } # Include the token in the headers
      get "/api/most_purchased_products_by_category", headers: headers
      expect(response).to have_http_status(:success)

      result = JSON.parse(response.body)
      expect(result).to have_key("most_purchased_products")
       # Debug assertions
      puts "Actual result:"
      puts result.inspect

      # Assert the size of most_purchased_products
      expect(result["most_purchased_products"]).to be_an(Array)
      expect(result["most_purchased_products"]).not_to be_empty
      expect(result["most_purchased_products"].size).to eq(5)

      assert_category_result(result, category1)
      assert_category_result(result, category2)
    end

    def create_test_data

      orderitem1 = build(:order_item,  product: product1)
      orderitem2 = build(:order_item, product: product2)
      orderitem3 = build(:order_item, product: product3)

      create_list(:order, 3,client: create(:client),sale: Sale.new,
        order_items: [orderitem1])
      create_list(:order, 2,client: create(:client),sale: Sale.new,
        order_items: [orderitem2])
      create_list(:order, 4,client: create(:client),sale: Sale.new,
        order_items: [orderitem3])
    end

    def assert_category_result(result, category)
      category_result = result["most_purchased_products"].find { |r| r["category_name"] == category.name }
      expect(category_result).not_to be_nil
      expect(category_result["products"].size).to eq(category.products.size)

      category.products.each do |product|
        assert_product_result(category_result["products"], product)
      end
    end

    def assert_product_result(products_result, product)
      product_result = products_result.find { |p| p["name"] == product.name }
      expect(product_result).not_to be_nil
      expect(product_result["sales_count"]).to eq(product.orders.distinct.count)
    end
  end
end
