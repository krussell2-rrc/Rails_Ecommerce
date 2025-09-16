class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, index: true, foreign_key: false
      t.references :product, null: false, index: true, foreign_key: false
      t.integer :quantity

      t.timestamps
    end
  end
end
