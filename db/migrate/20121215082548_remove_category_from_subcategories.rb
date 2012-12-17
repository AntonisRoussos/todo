class RemoveCategoryFromSubcategories < ActiveRecord::Migration
  def self.up
	rename_column :subcategories, :Category_code, :category_code
	remove_column :subcategories, :category_code
  end

  def self.down
	add_column :subcategories, :category_code, :string, :limit => 2
  end
end
