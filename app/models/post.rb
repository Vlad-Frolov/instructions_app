class Post < ApplicationRecord
    belongs_to :user
    belongs_to :category
    validates :title, presence: true
    
    default_scope -> { includes(:user).order(created_at: :desc) }
    scope :by_category, -> (category_name) do 
        joins(:category).where(categories: {name: category_name}) 
      end
    scope :search, -> (search) do
        where("title ILIKE lower(?) OR content ILIKE lower(?)", "%#{search}%", "%#{search}%")
    end
end
