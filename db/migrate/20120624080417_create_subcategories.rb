class CreateSubcategories < ActiveRecord::Migration
  def self.up
    create_table :subcategories do |t|
      t.string :Category_code, :limit => 2
      t.string :Subcategory_code, :limit => 2
      t.string :type, :limit => 1
      t.string :enDescription, :limit => 30
      t.string :elDescription, :limit => 30

      t.timestamps
    end
  end

  def self.down
    drop_table :subcategories
  end
end
