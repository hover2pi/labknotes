class ChangeDefaultTypeOfUsersToStudent < ActiveRecord::Migration
  def self.up
    change_column_default :users, :type, "Student"
  end

  def self.down
    change_column_default :users, :type, nil
  end
end
