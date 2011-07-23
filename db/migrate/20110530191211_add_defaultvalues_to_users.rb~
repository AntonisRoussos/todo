class AddDefaultvaluesToUsers < ActiveRecord::Migration
  def self.up
	change_column_default(:users, :status, false)
	change_column_default(:users, :family_view_access, false)
	change_column_default(:users, :family_assign_tasks, false)
	change_column_default(:users, :friends_view_access, false)
	change_column_default(:users, :friends_assign_access, false)
	change_column_default(:users, :employer_view_access, false)
	change_column_default(:users, :employer_assign_access, false)
	add_index :users, :email, :unique => true
  	
  end

  def self.down
   	change_column_default(:users, :status, nil)
	change_column_default(:users, :family_view_access, nil)
	change_column_default(:users, :family_assign_tasks, nil)
	change_column_default(:users, :friends_view_access, nil)
	change_column_default(:users, :friends_assign_access, nil)
	change_column_default(:users, :employer_view_access, nil)
	change_column_default(:users, :employer_assign_access, nil)
  	remove_index :users, :email
  end
end
