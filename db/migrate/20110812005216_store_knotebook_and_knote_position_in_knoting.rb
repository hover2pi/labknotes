class StoreKnotebookAndKnotePositionInKnoting < ActiveRecord::Migration
  def self.up
    rename_column :knotings, :position, :y
    add_column :knotings, :x, :integer, :default => 1
  end

  def self.down
    remove_column :knotings, :x
    rename_column :knotings, :y, :position
  end
end
