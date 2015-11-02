class CreateKnotings < ActiveRecord::Migration
  def self.up
    create_table :knotings do |t|
      t.belongs_to :knotebook
      t.belongs_to :knote
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :knotings
  end
end
