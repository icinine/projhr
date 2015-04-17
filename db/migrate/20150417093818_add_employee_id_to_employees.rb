class AddEmployeeIdToEmployees < ActiveRecord::Migration
  def change
    add_reference :employees, :employee, index: true
    add_foreign_key :employees, :employees
    add_column :employees, :employee_id, :integer
  end
end
