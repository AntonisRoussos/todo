class RenameColumnOnTasks < ActiveRecord::Migration
  def self.up
    rename_column :tasks, :type, :ttype
  end

  def self.down
    rename_column :tasks, :ttype, :type
  end
end
