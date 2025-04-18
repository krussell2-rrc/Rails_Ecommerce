class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.references :province, null: false, foreign_key: true
      t.string :street
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end
