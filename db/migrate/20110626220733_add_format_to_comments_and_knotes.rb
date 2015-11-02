class AddFormatToCommentsAndKnotes < ActiveRecord::Migration
  def self.up
    add_column :knotes, :format, :string, :default => "markdown"
    add_column :comments, :format, :string, :default => "markdown"
  end

  def self.down
    remove_column :comments, :format
    remove_column :knotes, :format
  end
end