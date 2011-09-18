class Task < ActiveRecord::Migration
  def self.up
     create_table :tasks do |t|
	t.references :user  
	t.string :type, :default => "P", :limit => 1
	t.integer :subtype, :limit => 2
	t.string :priority, :default => "L", :limit => 1
      	t.timestamp :due  
	t.timestamp :notification
      	t.boolean :repititive, :default => false
	t.timestamp :finish_on
	t.string :status, :default => "O", :limit => 1
      	t.timestamp :status_date
	t.integer :assigner 
	t.boolean :email_notification_to_assignee
      	t.boolean :sms_notification_to_assignee
      	t.boolean :email_notification_to_assigner
      	t.boolean :sms_notification_to_assigner
	t.string :accessible_by, :default => "N", :limit => 1
      	t.decimal :budget, :default => 0, :precision => 9, :scale => 2
	t.references :place  
     end
  end

  def self.down
      drop_table :tasks  
  end
  
end
