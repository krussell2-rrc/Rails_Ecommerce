class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.references :province, null: false, index: true, foreign_key: false
      t.string :street
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end
