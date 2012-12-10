class AddSubcattegoryIdToExpenses < ActiveRecord::Migration
  def self.up
  	change_table :expenses do |t|
    		t.references :subcategory
	end
  end

  def self.down
    	change_table :expenses do |t|
      		t.remove :subcategory_id
	end
  end
end
