class RemovePaidFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :paid_at
    remove_column :orders, :paid
  end
end
