class AddRoleToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :role, :string, default: 'client'
  end
end
