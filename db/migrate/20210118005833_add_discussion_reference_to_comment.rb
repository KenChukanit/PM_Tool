class AddDiscussionReferenceToComment < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :discussion, foreign_key: true
  end
end
