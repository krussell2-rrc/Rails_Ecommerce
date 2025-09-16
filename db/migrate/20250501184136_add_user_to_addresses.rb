class AddUserToAddresses < ActiveRecord::Migration[8.0]
  def change
    add_reference :addresses, :user, null: true, index: true, foreign_key: false
  end
end
