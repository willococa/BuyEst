class ProductCategory < ApplicationRecord
    has_paper_trail
    has_and_belongs_to_many :products, class_name: 'Product'
end
