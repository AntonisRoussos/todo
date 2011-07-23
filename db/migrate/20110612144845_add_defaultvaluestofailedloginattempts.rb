class AddDefaultvaluestofailedloginattempts < ActiveRecord::Migration
  def self.up
	  change_column_default(:users, :failedlogin, 0)
  end

  def self.down
	  change_column_default(:users, :failedlogin, nil)
  end
end
