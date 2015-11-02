class AddSubmittedAtToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :submitted_at, :datetime
  end

  def self.down
    remove_column :reports, :submitted_at
  end
end
