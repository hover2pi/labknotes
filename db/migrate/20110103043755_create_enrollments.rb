class CreateEnrollments < ActiveRecord::Migration
  def self.up
    create_table :enrollments do |t|
      t.references :student
      t.references :course

      t.timestamps
    end
  end

  def self.down
    drop_table :enrollments
  end
end
