// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ajax:success', function (e, data) {
  console.log('Ajax Response Data:', data);
});

$(document).ready(function(){
  $('#new-member-form').on('ajax:success',function(data, status, xhr){
    console.log(status);
  }).on('ajax:error',function(xhr, status, error){
    console.log("xhr", xhr);
    
    console.log(error);
  });
  console.log($('#new-member-form'));
});