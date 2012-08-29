class AddCategoriesCategoryUniquenessIndex < ActiveRecord::Migration
  def self.up
	add_index :categories, :code, :unique => true
  end

  def self.down
  	remove_index :categories, :code
  end
end
