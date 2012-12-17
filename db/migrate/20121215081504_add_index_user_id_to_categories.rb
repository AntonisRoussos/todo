class AddIndexUserIdToCategories < ActiveRecord::Migration
  def self.up
	add_index :categories, :user_id
  end

  def self.down
	remove_index :categories, :user_id
  end
end
