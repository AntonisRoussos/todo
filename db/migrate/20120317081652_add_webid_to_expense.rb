class AddWebidToExpense < ActiveRecord::Migration
  def self.up
    add_column :expenses, :webid, :integer
  end

  def self.down
    remove_column :expenses, :webid
  end
end
