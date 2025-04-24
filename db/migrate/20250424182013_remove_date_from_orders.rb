class RemoveDateFromOrders < ActiveRecord::Migration[8.0]
  def change
    remove_column :orders, :order_date, :datetime
  end
end
