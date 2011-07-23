class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
	t.string :name
      	t.string :email    
	t.string :encrypted_password
	t.string :salt	
       	t.boolean :status
      	t.boolean :family_view_access
      	t.boolean :family_assign_tasks
      	t.boolean :friends_view_access
      	t.boolean :friends_assign_access
      	t.boolean :employer_view_access
      	t.boolean :employer_assign_access
	t.timestamps
    end
  end

  def self.down
	drop_table :users  
  end
end
