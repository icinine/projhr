class RemoveDeptFromEmployees < ActiveRecord::Migration
  def change
    remove_column :employees, :dept, :string
    add_column :employees, :dept_id, :integer
  end
end
