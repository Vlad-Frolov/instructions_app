class PagesController < ApplicationController
    def index
        @latest = Post.order('updated_at').limit(5)
        @favorite = Post.joins("RIGHT OUTER JOIN rating_caches ON rating_caches.cacheable_id = posts.id")
                                            .order('avg desc').limit(5)
    end
end