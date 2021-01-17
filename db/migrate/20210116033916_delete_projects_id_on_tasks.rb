class DeleteProjectsIdOnTasks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :tasks, :projects, foreign_key: true
  end
end
