class Product < ApplicationRecord
    include TrackChanges
    has_many_attached :images    
    has_and_belongs_to_many :product_categories, class_name: 'ProductCategory'
    has_many :order_items
    has_many :orders, through: :order_items
    # Validation rules
    validates :name, presence: true
    validates :cost, presence: true
    validates :product_category_ids, presence: true
    validates :description, presence: true
    validates :images, presence: { message: 'must have at least one image' }    
end
