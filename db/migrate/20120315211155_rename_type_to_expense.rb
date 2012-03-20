class RenameTypeToExpense < ActiveRecord::Migration
  def self.up
    rename_column :expenses, :type, :ttype
    change_column(:expenses, :category, :string, :default => '01', :limit => 2)
    change_column(:expenses, :subcategory, :string, :default => '0101', :limit => 4)
    change_column(:expenses, :ttype, :string, :default => 'E', :limit => 1)
    change_column(:expenses, :method, :string, :default => 'M', :limit => 1)
    change_column(:expenses, :amount, :decimal, :default => 0, :precision => 9, :scale => 2)
  end

  def self.down
    rename_column :expenses, :ttype, :type
  end
end
