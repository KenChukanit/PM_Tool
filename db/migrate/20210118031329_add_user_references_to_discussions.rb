class AddUserReferencesToDiscussions < ActiveRecord::Migration[6.1]
  def change
    add_reference :discussions, :user, foreign_key: true
  end
end
