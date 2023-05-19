class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :client, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.decimal :total
      t.string :payment_method

      t.timestamps
    end
  end
end
