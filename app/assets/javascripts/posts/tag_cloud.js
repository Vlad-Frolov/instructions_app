$(function(){
    // var classes = ["label label-primary","label label-success","label ","label label-warning","label label-default","label label-default","label label-danger"];
    $(".tagcloud").hide();
    $(".label").click(function(){
      $(this).removeClass('label-success').addClass('label-warning');
      $(this).siblings().removeClass('label-warning').addClass('label-success');
    });
    $("p").click(function(){
      $(".tagcloud").slideToggle(500);

    });
    
});