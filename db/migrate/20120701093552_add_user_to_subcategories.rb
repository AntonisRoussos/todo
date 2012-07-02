class AddUserToSubcategories < ActiveRecord::Migration
  def self.up
  	change_table :subcategories do |t|
    		t.references :user
	end
  end

  def self.down
    	change_table :subcategories do |t|
      		t.remove :user_id
	end
  end
end
