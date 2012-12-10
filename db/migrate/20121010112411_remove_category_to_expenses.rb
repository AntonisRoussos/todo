class RemoveCategoryToExpenses < ActiveRecord::Migration
  def self.up
  	remove_index :categories, :code
  	remove_index :subcategories, [:Category_code, :Subcategory_code]
	remove_column :expenses, :category
	remove_column :expenses, :subcategory
  end

  def self.down
	add_index :categories, :code, :unique => true
	add_index :subcategories, [:Category_code, :Subcategory_code], :unique => true
	add_column :expenses, :category, :string, :limit => 2
	add_column :expenses, :subcategory, :string, :limit => 2
  end
end
