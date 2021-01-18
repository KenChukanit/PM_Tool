class Comment < ApplicationRecord
    belongs_to :discussion
    belongs_to :user, optional: true
    validates :body, presence: {message: 'must be provided'}
end
