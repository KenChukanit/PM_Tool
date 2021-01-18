class Discussion < ApplicationRecord
    belongs_to :project
    has_many :comments
    validates :title, presence: {message: 'must be provided'}
end
