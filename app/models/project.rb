class Project < ApplicationRecord
    has_many :tasks
    validates :title, presence: {message: 'must be provided'},uniqueness: true
end
