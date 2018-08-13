class PagesController < ApplicationController
    def index
        @posts = Post.all.order("updated_at DESC").limit(7)
    end
end