class RenameTypeOnSubcategory < ActiveRecord::Migration
  def self.up
    rename_column :subcategories, :type, :ttype
  end

  def self.down
    rename_column :subcategories, :ttype, :type
  end
end
