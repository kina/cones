class RemoveUsedFromCredit < ActiveRecord::Migration
  def change
    remove_column :credits, :used
  end
end
