class AddTimestampsToTasks < ActiveRecord::Migration
  def self.up
   add_column :tasks, :created_at, :timestamp
   add_column :tasks, :updated_at, :timestamp
  end

  def self.down
    remove_column :tasks, :created_at
    remove_column :tasks, :updated_at
  end

end
