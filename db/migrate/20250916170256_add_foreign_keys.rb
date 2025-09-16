class AddForeignKeys < ActiveRecord::Migration[8.0]
  def up
    add_fk(:addresses,        :provinces)
    add_fk(:addresses,        :users)
    add_fk(:cart_items,       :carts)
    add_fk(:cart_items,       :products)
    add_fk(:invoice_products, :invoices)
    add_fk(:invoice_products, :products)
    add_fk(:order_items,      :orders)
    add_fk(:order_items,      :products)
    add_fk(:products,         :categories)
    add_fk(:users,            :provinces)
  end

  def down
    # safe rollback: only remove if present
    rm_fk(:addresses,        :provinces)
    rm_fk(:addresses,        :users)
    rm_fk(:cart_items,       :carts)
    rm_fk(:cart_items,       :products)
    rm_fk(:invoice_products, :invoices)
    rm_fk(:invoice_products, :products)
    rm_fk(:order_items,      :orders)
    rm_fk(:order_items,      :products)
    rm_fk(:products,         :categories)
    rm_fk(:users,            :provinces)
  end

  private

  def add_fk(from, to, **opts)
    return if foreign_key_exists?(from, to, **opts)
    add_foreign_key(from, to, **opts)
  end

  def rm_fk(from, to, **opts)
    return unless foreign_key_exists?(from, to, **opts)
    remove_foreign_key(from, to, **opts)
  end
end
