class Discussion < ApplicationRecord
    belongs_to :project
    has_many :comments, dependent: :destroy
    belongs_to :user, optional: true
    validates :title, presence: {message: 'must be provided'}
    validates :description, presence: {message: 'must be provided'}
end
