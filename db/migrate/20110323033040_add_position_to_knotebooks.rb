class AddPositionToKnotebooks < ActiveRecord::Migration
  def self.up
    add_column :knotebooks, :position, :integer
  end

  def self.down
    remove_column :knotebooks, :position
  end
end
