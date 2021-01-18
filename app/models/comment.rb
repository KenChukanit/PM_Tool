class Comment < ApplicationRecord
    belongs_to :discussion
    validates :body, presence: {message: 'must be provided'}
end
