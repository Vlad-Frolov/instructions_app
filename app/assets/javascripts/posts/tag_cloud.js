$(function(){
    $(".tagcloud").hide();
    $(".label").click(function(){
      $(this).removeClass('label-success').addClass('label-warning');
      $(this).siblings().removeClass('label-warning').addClass('label-success');
    });
    $("p").click(function(){
      $(".tagcloud").slideToggle(500);

    });
    
});