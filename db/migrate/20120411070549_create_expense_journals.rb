class CreateExpenseJournals < ActiveRecord::Migration
  def self.up
    create_table :expense_journals do |t|
      t.string :trxtype, :limit => 1
      t.timestamp :trxdatetime
      t.integer :sn
      t.decimal :amount, :default => 0, :precision => 9, :scale => 2
      t.date :dateoccured
      t.string :category, :limit => 2
      t.string :subcategory, :limit => 4
      t.string :exptype, :limit => 1
      t.string :expmethod, :limit => 1

      t.timestamps
    end
  end
  def self.down
    drop_table :expense_journals
    trigger.drop_triggers

  end
end
