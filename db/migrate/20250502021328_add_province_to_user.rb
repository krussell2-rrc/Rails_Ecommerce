class AddProvinceToUser < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :province, null: true, index: true, foreign_key: false
  end
end
