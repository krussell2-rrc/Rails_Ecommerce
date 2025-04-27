class AddQuantityToInvoiceProduct < ActiveRecord::Migration[8.0]
  def change
    add_column :invoice_products, :quantity, :integer
  end
end
