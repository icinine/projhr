class RemoveStringFromEmployees < ActiveRecord::Migration
  def change
    remove_column :employees, :string, :string
  end
end
