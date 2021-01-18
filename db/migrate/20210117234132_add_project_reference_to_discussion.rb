class AddProjectReferenceToDiscussion < ActiveRecord::Migration[6.1]
  def change
    add_reference :discussions, :project, foreign_key: true
  end
end
