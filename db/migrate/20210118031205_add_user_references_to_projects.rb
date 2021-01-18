class AddUserReferencesToProjects < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :user, foreign_key: true
  end
end
