class Discussion < ApplicationRecord
    validates :title, presence: {message: 'must be provided'}
end
