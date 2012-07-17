class AddUsedToCredit < ActiveRecord::Migration
  def change
    add_column :credits, :used, :boolean, default: false
  end
end
