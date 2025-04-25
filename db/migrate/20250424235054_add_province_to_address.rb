class AddProvinceToAddress < ActiveRecord::Migration[8.0]
  def change
    add_column :addresses, :province, :string
  end
end
