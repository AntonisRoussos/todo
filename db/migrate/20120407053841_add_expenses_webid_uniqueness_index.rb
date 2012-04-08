class AddExpensesWebidUniquenessIndex < ActiveRecord::Migration
  def self.up
	add_index :expenses, :webid, :unique => true
  end

  def self.down
  	remove_index :expenses, :webid
  end
end
