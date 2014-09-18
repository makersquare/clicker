// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ajax:success', function (e, data) {
  console.log('Ajax Response Data:', data);
});
