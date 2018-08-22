function searchPosts(){
    var value = document.getElementById('main_search_field').value;
    document.location.href='/posts?val=' + value;
  }
