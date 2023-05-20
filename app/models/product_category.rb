class ProductCategory < ApplicationRecord
    include TrackChanges
    has_and_belongs_to_many :products, class_name: 'Product'    
    validates :name, :description, presence: true
end
