class AddCryptopassUniquenessIndex < ActiveRecord::Migration
  def self.up
	add_index :users, :cryptopass, :unique => true
  end

  def self.down
  	remove_index :users, :cryptopass
  end
end
