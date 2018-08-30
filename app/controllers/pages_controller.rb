class PagesController < ApplicationController
    def index
      # @latest = Post.order('updated_at desc').limit(5)
    #   @posts = Post.left_outer_joins("rating_caches ON rating_caches.cacheable_id = posts.id")
        @posts = Post.all
    end
end