class AddCourseToKnotebooks < ActiveRecord::Migration
  def self.up
    add_column :knotebooks, :course_id, :integer
  end

  def self.down
    remove_column :knotebooks, :course
  end
end
