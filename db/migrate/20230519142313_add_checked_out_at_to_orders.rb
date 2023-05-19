class AddCheckedOutAtToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :checked_out_at, :datetime
  end
end
