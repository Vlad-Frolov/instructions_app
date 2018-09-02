module PostsHelper
    
  def create_new_post_partial_path
    if user_signed_in?
      'posts/create_new_post/signed_in'
    else
      'posts/create_new_post/not_signed_in'
    end
  end
  
  def no_posts_path
    @posts.empty? ? 'posts/shared/no_posts' : 'posts/shared/empty_partial'
  end
  
  def all_categories_button_path
    if params[:category].blank?
      'posts/categories/all_selected'
    else
      'posts/categories/all_not_selected'
    end
  end

  def update_pagination_partial_path
    if @posts.next_page
      'posts/posts_pagination_page/update_pagination'
    else
      'posts/posts_pagination_page/remove_pagination'
    end
  end

  def category_field_partial_path
    if params[:category].present?
      'posts/search_form/category_field'
    else
      'posts/shared/empty_partial'
    end
  end
    

end
