class AddStateToKnotebooks < ActiveRecord::Migration
  def self.up
    add_column :knotebooks, :state, :string
  end

  def self.down
    remove_column :knotebooks, :state
  end
end
