class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_hash
      t.string :email_address

      t.timestamps
    end
  end
end
