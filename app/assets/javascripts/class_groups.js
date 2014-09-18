// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


// app = angular.module("Clicker", ["ngResource"])

// app.factory "QuestionSet", ($resource) ->
//   $resource("question_set")

$('#new-class-div').hide();

// CLICK event handlers ------------------------------------------------ CLICK
$('#add-a-class').click(function (e) {
  // slides down add-class form
  $('#new-class-div').animate({
    height:'toggle'
  });
});

// on click cancel button, hides the add-class form
$('.new-class-cancel').click(function (e) {
    $('#new-class-div').animate({
    height:'toggle'
    });
});

// TOUCH event handlers -------------------------------------------------- TOUCH
$('#add-a-class').on('tap', function (e) {
  // slides down add-class form
  $('#new-class-div').animate({
    height:'toggle'
  });
});

// on TOUCH cancel button, hides the add-class form
$('.new-class-cancel').on('tap', function (e) {
    $('#new-class-div').animate({
    height:'toggle'
    });
});
  