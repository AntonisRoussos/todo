class AddSubCategoriesSubCategoryUniquenessIndex < ActiveRecord::Migration
  def self.up
	add_index :subcategories, [:Category_code, :Subcategory_code], :unique => true
  end

  def self.down
  	remove_index :subcategories, [:Category_code, :Subcategory_code]
  end
end
