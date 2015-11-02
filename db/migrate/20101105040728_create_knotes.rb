class CreateKnotes < ActiveRecord::Migration
  def self.up
    create_table :knotes do |t|
      t.string :title
      t.text :content
      t.belongs_to :professor
      t.integer :difficulty

      t.timestamps
    end
  end

  def self.down
    drop_table :knotes
  end
end
