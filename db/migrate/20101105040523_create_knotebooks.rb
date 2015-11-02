class CreateKnotebooks < ActiveRecord::Migration
  def self.up
    create_table :knotebooks do |t|
      t.string :title
      t.text :abstract
      t.belongs_to :professor
      t.boolean :favorite, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :knotebooks
  end
end
