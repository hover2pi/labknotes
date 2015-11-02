class AddSpreadsheetToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :spreadsheet, :boolean, :default => false
  end

  def self.down
    remove_column :questions, :spreadsheet
  end
end
