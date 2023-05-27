class Api::SalesController < Api::ApplicationController
  before_action :authenticate_user

  def most_purchased_products_by_category
    # Your code to retrieve purchases

    categories = ProductCategory.includes(:products).includes(:products => :orders)
    result = []

    categories.find_each do |category|
      most_purchased_products = category.products
                                    .purchased
                                    .group('products.id')
                                    .select('products.id, products.name, COUNT(DISTINCT orders.id) AS sales_count')
                                    .order('COUNT(orders.id) DESC')

      result << { category_name: category.name, products: most_purchased_products }
    end

    render json: { most_purchased_products: result }
  end

  # Other actions
end
