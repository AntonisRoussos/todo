class RenameDateoccuredOnExpenses < ActiveRecord::Migration
  def self.up
    rename_column :expenses, :dateOccured, :dateoccured
  end

  def self.down
    rename_column :expenses, :dateoccured, :dateOccured
  end
end
