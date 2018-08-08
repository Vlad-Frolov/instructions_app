class PagesController < ApplicationController

    def index
        @posts = Post.limit(100)
      end

end
