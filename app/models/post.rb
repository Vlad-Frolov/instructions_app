class Post < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :categories
    validates :title, presence: true
end
