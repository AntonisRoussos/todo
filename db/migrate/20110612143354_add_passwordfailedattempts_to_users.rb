class AddPasswordfailedattemptsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :failedlogin, :integer, :limit => 1
  end

  def self.down
    remove_column :users, :failedlogin
  end
end
