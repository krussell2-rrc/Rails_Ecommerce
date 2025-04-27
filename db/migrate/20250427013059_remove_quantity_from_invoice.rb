class RemoveQuantityFromInvoice < ActiveRecord::Migration[8.0]
  def change
    remove_column :invoices, :quantity, :integer
  end
end
