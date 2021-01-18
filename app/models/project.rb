class Project < ApplicationRecord
    has_many :tasks, dependent: :destroy
    has_many :discussions, dependent: :destroy
    belongs_to :user, optional: true
    validates :title, presence: {message: 'must be provided'},uniqueness: true
end
