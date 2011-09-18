class AddDescriptionToPlace < ActiveRecord::Migration
  def self.up
    add_column :places, :description, :string, :limit => 25
  end

  def self.down
    remove_column :places, :description
  end
end
