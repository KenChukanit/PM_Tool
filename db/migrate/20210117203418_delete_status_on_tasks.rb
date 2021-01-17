class DeleteStatusOnTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :status, :boolean
  end
end
