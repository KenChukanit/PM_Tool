class Comment < ApplicationRecord
    validates :body, presence: {message: 'must be provided'}
end
