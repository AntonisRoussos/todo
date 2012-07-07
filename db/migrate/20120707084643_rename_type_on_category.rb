class RenameTypeOnCategory < ActiveRecord::Migration
  def self.up
    rename_column :categories, :type, :ttype
  end

  def self.down
    rename_column :categories, :ttype, :type
  end
end
