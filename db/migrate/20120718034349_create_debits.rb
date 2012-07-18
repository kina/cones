class CreateDebits < ActiveRecord::Migration
  def change
    create_table :debits do |t|
      t.integer :customer_id
      t.decimal :value, precision: 8, scale: 2

      t.timestamps
    end
  end
end
