class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.string :order_status
      t.decimal :order_tax
      t.float :grand_total
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
