class Project < ApplicationRecord
    has_many :tasks
    has_many :discussions
    belongs_to :user, optional: true
    validates :title, presence: {message: 'must be provided'},uniqueness: true
end
