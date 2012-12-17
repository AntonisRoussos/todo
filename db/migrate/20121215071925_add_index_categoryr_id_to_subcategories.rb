class AddIndexCategoryrIdToSubcategories < ActiveRecord::Migration
  def self.up
	add_index :subcategories, :category_id
  end

  def self.down
	remove_index :subcategories, :category_id
  end
end
