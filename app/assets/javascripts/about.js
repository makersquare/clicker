$(document).ready(function(){
  $("img.hex-img").hover(function(){
    $("p").css("opacity","0.6");
    },function(){
    $("p").css("background-color","pink");
  });
});