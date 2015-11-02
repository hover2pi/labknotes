class AddDueDateToKnotebooks < ActiveRecord::Migration
  def self.up
    add_column :knotebooks, :due_at, :datetime
  end

  def self.down
    remove_column :knotebooks, :due_at
  end
end
