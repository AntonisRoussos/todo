class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.decimal :longtitude, :default => 0, :precision => 10, :scale => 8
      t.decimal :lattitude, :default => 0, :precision => 10, :scale => 8
      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
