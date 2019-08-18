class AddSalaryToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :salary, :string
  end
end
