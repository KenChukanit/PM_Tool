class Discussion < ApplicationRecord
    belongs_to :project
    has_many :comments
    belongs_to :user, optional: true
    validates :title, presence: {message: 'must be provided'}
end
