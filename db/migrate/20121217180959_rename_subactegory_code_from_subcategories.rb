class RenameSubactegoryCodeFromSubcategories < ActiveRecord::Migration
  def self.up
    rename_column :subcategories, :Subcategory_code, :subcategory_code
  end

  def self.down
    rename_column :subcategories, :subcategory_code, :Subcategory_code
  end
end
