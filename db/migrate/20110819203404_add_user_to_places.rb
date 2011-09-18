class AddUserToPlaces < ActiveRecord::Migration
  def self.up
    add_column :places, :user, :integer
  end

  def self.down
    remove_column :places, :user
  end
end
