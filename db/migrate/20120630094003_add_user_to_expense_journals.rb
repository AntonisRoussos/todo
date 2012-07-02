class AddUserToExpenseJournals < ActiveRecord::Migration
  def self.up
  	change_table :expense_journals do |t|
    		t.references :user
	end
  end

  def self.down
    	change_table :expense_journals do |t|
      		t.remove :user_id
	end
  end
end
