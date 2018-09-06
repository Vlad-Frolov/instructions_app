function searchPosts(){
    var value = document.getElementById('main_search_field').value;
    document.location.href='/posts?val=' + value;
  }

function handleKeyPress(e){
  var key=e.keyCode || e.which;
   if (key==13){
    searchPosts();
   }
 }