class AddDescriptionToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :description, :string, :limit => 30
#    add_column :tasks, :long_description, :text, :limit => 120
    add_column :tasks, :long_description, :text
   end

  def self.down
    remove_column :tasks, :long_description
    remove_column :tasks, :description
  end
end
