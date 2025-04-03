class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :product_img
      t.string :product_name
      t.float :product_price
      t.text :product_description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
