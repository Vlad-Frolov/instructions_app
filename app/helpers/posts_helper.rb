module PostsHelper
    def create_new_post_partial_path
        if user_signed_in?
          'posts/create_new_post/signed_in'
        else
          'posts/create_new_post/not_signed_in'
        end
      end
end
