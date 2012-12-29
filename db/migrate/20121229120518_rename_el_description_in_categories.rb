class RenameElDescriptionInCategories < ActiveRecord::Migration
  def self.up
    rename_column :categories, :elDescription, :eldescription
    rename_column :categories, :enDescription, :endescription
    rename_column :subcategories, :elDescription, :eldescription
    rename_column :subcategories, :enDescription, :endescription
  end

  def self.down
    rename_column :categories, :eldescription, :elDescription
    rename_column :categories, :endescription, :enDescription
    rename_column :subcategories, :eldescription, :elDescription
    rename_column :subcategories, :endescription, :enDescription
  end
end
