class AddSelectedlanguageToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :selected_language, :string, :limit => 2, :default => "el"
  end

  def self.down
    remove_column :users, :selected_language
  end
end
