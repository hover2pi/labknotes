class AddStudentIdToStudents < ActiveRecord::Migration
  def self.up
    add_column :users, :student_id, :integer, :unique => true
  end

  def self.down
    remove_column :users, :student_id
  end
end
