class IncreaseEmailLengthToUsers < ActiveRecord::Migration
  def self.up
     change_column(:users, :email, :string, :limit => 45)
  end

  def self.down
     change_column(:users, :email, :string, :limit => 255)
  end
end
