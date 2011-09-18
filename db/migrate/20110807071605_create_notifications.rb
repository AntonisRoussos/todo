class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
	t.references :user  
	t.string :type, :limit => 1
	t.integer :assigner
	t.timestamp :when
	t.string :status, :default => "N", :limit => 1
        t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
