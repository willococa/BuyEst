class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_price, :items_count
end
