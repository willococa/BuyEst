class AddCurrentOrderIdAndCheckedOutToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :current_order_id, :integer
    add_index :clients, :current_order_id
  end
end
