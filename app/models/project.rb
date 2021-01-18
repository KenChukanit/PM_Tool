class Project < ApplicationRecord
    has_many :tasks
    has_many :discussions
    validates :title, presence: {message: 'must be provided'},uniqueness: true
end
