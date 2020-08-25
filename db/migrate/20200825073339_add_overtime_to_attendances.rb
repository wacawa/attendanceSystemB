class AddOvertimeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :work_overtime, :string
    add_column :attendances, :overtime_instructor, :string
  end
end
