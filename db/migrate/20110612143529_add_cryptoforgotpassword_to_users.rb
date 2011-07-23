class AddCryptoforgotpasswordToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :cryptopass, :string, :limit => 4
  end

  def self.down
    remove_column :users, :cryptopass
  end
end
