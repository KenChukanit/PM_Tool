class Project < ApplicationRecord
    has_many :tasks, dependent: :destroy
    has_many :discussions, dependent: :destroy
    belongs_to :user, optional: true
    has_many  :favourites, dependent: :destroy
    has_many  :users_who_favour,  through: :favourites, source: :user

    validates :title, presence: {message: 'must be provided'},uniqueness: true
    # validate :due_date_greater_than_created_at

    def self.all_with_discussion_counts
        self.left_outer_joins(:discussions)
            .select("projects.*","Count(discussions.*) AS discussions_count")
            .group('projects.id')
    end

  
    private

    def due_date_greater_than_created_at
    return unless due_date.present? 

    errors.add(:due_date, "due_date must be greater than created_at") if due_date <= created_at 
    end

end
