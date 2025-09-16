class CreateInvoiceProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :invoice_products do |t|
      t.references :product, null: false, index: true, foreign_key: false
      t.references :invoice, null: false, index: true, foreign_key: false

      t.timestamps
    end
  end
end
