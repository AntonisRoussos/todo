class AddTimeforgotpasswordToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :time_forgot_password, :datetime
  end

  def self.down
    remove_column :users, :time_forgot_password
  end
end
