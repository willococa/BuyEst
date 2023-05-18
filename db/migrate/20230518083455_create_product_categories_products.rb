class CreateProductCategoriesProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :product_categories_products, id: false do |t|
      t.belongs_to :product_category
      t.belongs_to :product
      t.timestamps
    end
  end
end
