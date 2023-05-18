class Product < ApplicationRecord
    has_many_attached :images    
    has_and_belongs_to_many :product_categories, class_name: 'ProductCategory'
    has_many :order_items
    has_many :orders, through: :order_items
end
