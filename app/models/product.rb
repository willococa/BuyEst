class Product < ApplicationRecord
    has_many_attached :images    
    has_and_belongs_to_many :product_categories, class_name: 'ProductCategory'
end
