class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :customer_id
      t.decimal :value

      t.timestamps
    end
  end
end
