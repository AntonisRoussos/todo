class ChangeSubcategoryExpenses < ActiveRecord::Migration
  def self.up
    change_column(:expenses, :subcategory, :string, :default => '01', :limit => 2)
    change_column(:expense_journals, :subcategory, :string, :default => '01', :limit => 2)
  end

  def self.down
    change_column(:expenses, :subcategory, :string, :default => '0101', :limit => 4)
    change_column(:expense_journals, :subcategory, :string, :default => '0101', :limit => 4)
  end
end
