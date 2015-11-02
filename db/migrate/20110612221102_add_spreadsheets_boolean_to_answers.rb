class AddSpreadsheetsBooleanToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :spreadsheet, :boolean, :default => false
  end

  def self.down
    remove_column :answers, :spreadsheet
  end
end
