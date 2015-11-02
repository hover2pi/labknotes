class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.references :student
      t.references :knotebook
      t.float :grade
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
