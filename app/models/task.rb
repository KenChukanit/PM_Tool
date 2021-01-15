class Task < ApplicationRecord
    validates :title, presence: {message: 'must be provided'},uniqueness: true
end
