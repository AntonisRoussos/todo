class RenameExpensesWebidToMobidAndAddSync < ActiveRecord::Migration
  def self.up
    add_column :expenses, :sync, :char, :limit => 1
    rename_column :expenses, :webid, :mobileid 
  end

  def self.down
    remove_column :expenses, :sync
    rename_column :expenses, :mobileid, :webid
  end
end
