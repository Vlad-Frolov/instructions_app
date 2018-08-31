class Post < ApplicationRecord
    include SearchCop
    belongs_to :user
    belongs_to :category
    validates :title, presence: true, length: { minimum: 5, maximum: 255 }
    validates :content, presence: true, length: { minimum: 20 }
    validates :category_id, presence: true
    has_many :steps
    has_many :comments, dependent: :destroy
    acts_as_ordered_taggable

    search_scope :search do
      attributes :title, :content
      attributes comment: 'comments.text'
      attributes step: ['steps.content', 'steps.name']
      options :all, :type => :fulltext
    end

    ratyrate_rateable 'original_score'

    scope :by_category, -> (category_name) do 
        includes(:category).where(categories: {name: category_name}) 
      end

    def avg_rating_dimension(post)
      array = Rate.where(rateable_id: id, rateable_type: 'Post').where(dimension: 'original_score')
      stars = array.map {|post| post.stars }
      star_count = stars.count
      stars_total = stars.inject(0){|sum,x| sum + x }
      score = stars_total / (star_count.nonzero? || 1)
    end
    
end

#adminka
#search
