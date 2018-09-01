module PagesHelper
    def latest_posts
        @posts = Post.order('updated_at DESC').limit(5)
    end

    def favorite_posts
        @posts = Post.joins("RIGHT OUTER JOIN rating_caches ON rating_caches.cacheable_id = posts.id").limit(5)
    end
end
