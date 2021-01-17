class Task < ApplicationRecord
    belongs_to :project

    enum status:    [:uncompleted, :completed]
    validates :title, presence: {message: 'must be provided'},uniqueness: true
    validates :body, presence: {message: 'must be provided'},uniqueness: true
end
