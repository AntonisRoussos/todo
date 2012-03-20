class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.decimal :amount
      t.date :dateOccured
      t.string :category
      t.string :subcategory
      t.string :type
      t.string :method

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
