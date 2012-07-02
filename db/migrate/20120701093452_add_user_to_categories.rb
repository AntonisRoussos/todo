class AddUserToCategories < ActiveRecord::Migration
  def self.up
  	change_table :categories do |t|
    		t.references :user
	end
  end

  def self.down
    	change_table :categories do |t|
      		t.remove :user_id
	end
  end
end
