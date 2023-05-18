class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :cost
      t.boolean :has_first_sale

      t.timestamps
    end
  end
end
