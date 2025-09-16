class AddAllForeignKeys < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :addresses,       :provinces
    add_foreign_key :addresses,       :users
    add_foreign_key :cart_items,      :carts
    add_foreign_key :cart_items,      :products
    add_foreign_key :invoice_products,:invoices
    add_foreign_key :invoice_products,:products
    add_foreign_key :order_items,     :orders
    add_foreign_key :order_items,     :products
    add_foreign_key :orders,          :customers
    add_foreign_key :products,        :categories
    add_foreign_key :users,           :provinces
  end
end
