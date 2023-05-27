class Sale < ApplicationRecord
  belongs_to :client
  belongs_to :order, optional: true
  has_many :products, through: :order
end
