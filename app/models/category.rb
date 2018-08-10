class Category < ApplicationRecord
    has_many :posts, through: :posts_categories
end
