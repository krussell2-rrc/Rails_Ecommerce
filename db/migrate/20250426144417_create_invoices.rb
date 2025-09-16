class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :product, null: false, index: true, foreign_key: false
      t.decimal :gst
      t.decimal :pst
      t.decimal :hst
      t.decimal :subtotal
      t.decimal :total
      t.string :street
      t.string :city
      t.string :postal_code
      t.string :country
      t.integer :province_id

      t.timestamps
    end
  end
end
