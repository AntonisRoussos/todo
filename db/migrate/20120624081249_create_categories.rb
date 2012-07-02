class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :code, :limit => 2
      t.string :type, :limit => 1
      t.string :enDescription, :limit => 30
      t.string :elDescription, :limit => 30

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
