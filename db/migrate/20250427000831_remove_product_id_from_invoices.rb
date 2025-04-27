class RemoveProductIdFromInvoices < ActiveRecord::Migration[8.0]
  def change
    remove_column :invoices, :product_id, :integer
  end
end
