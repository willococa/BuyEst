class CreateJoinTableProductProductCategory < ActiveRecord::Migration[7.0]
  def change
    create_join_table :products, :product_categories, table_name: :products_categories do |t|
      t.index [:product_id, :product_category_id], name: 'index_products_categories_on_product_id_and_category_id'
      t.index [:product_category_id, :product_id], name: 'index_products_categories_on_category_id_and_product_id'
    end    
  end
end
