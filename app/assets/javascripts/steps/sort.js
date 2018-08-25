function updateDiv(){
    window.location.reload();
}

$(function  () {
    $('tbody.example').sortable();
  });
  var ready, set_positions;
  
  set_positions = function(){
      // loop through and give each task a data-pos
      // attribute that holds its position in the DOM
      $('.list_item').each(function(i){
          $(this).attr('data-pos',i+1);
      });
  }
  
  $(document).ready(function(){
      // call set_positions function
  
      set_positions();
  
      $('#steps_list').sortable();
  
      $('#steps_list').sortable().bind('sortupdate', function(e, ui) {
          // array to store new order
          updated_order = []
          // set the updated positions
          set_positions();
  
          // populate the updated_order array with the new task positions
          $('.list_item').each(function(i){
              updated_order.push({ id: $(this).data('id'), position: i+1 });
          });
  
          // send the updated order via ajax
          $.ajax({
              type: 'PUT',
              url: '/steps/sort',
              data: { order: updated_order }
          });
      });
  });