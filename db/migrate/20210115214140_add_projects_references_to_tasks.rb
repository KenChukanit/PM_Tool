class AddProjectsReferencesToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :tasks, :projects, foreign_key: true
  end
end
